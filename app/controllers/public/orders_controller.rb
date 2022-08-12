class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = current_customer.addresses.all
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    # order_detailに保存する。
    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.amount = cart_item.amount
      @order_detail.price = (cart_item.item.with_tax_price).floor
      @order_detail.save
    end
    #ループを終了する

    # ここからはカート内を削除する
    current_customer.cart_items.destroy_all
    redirect_to orders_complete_path
    # hiddenでorderに保存するためconfirmに記述すること。
    # orderはviewでorderdetailはコントローラーで記述する理由はなぜ？adminとcustomerでわかれているから？質問する
    # 答え：f.submitを開始したときに作動するのがcreateメソッド、これが上から順に始まる。その中に"OrderDetailの保存"を組み込むことによってカート商品それぞれをeach文の繰り返しによってすべて各々保存される。
    # 表示する必要がないので、コントローラに記述。
  end

  def complete
  end

  def index
    @orders = Order.all
    @order_detail = OrderDetail.all
  end

  def show
    @order = Order.find(params[:id])
    @order_detail = @order.order_details
  end

  def confirm

    @order = Order.new
    # ここで、new(order_params)にしない!このあとのaddress_optionなどがparamsによってはじかれてしまう為。
    @order.payment_method = params[:order][:payment_method]
    # orderの中payment_methodを許可してあげた
    @cart_items = current_customer.cart_items.all
    # [:address_option] == "0"のデータを呼び出す
    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.fullname

    elsif params[:order][:address_option] == "1"
      @address = Address.find(params[:order][:address_id])
      # ここがわからないから
        #orderのcustomer_id(カラム)でアドレス(帳)を選び、そのデータを送る
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name

    elsif params[:order][:address_option] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]

    else
      render 'new'
    end

  end

  private
    def order_params
      params.require(:order).permit(:postal_code, :name, :address, :customer_id, :postage, :payment_method, :total_payment, :status, :address_id, :address_option)
    # permit()の中身はカラムを入れるのではなく、送られる値を入れてその値は通行可能という許可をだすもの。なので今回データベースにないaddress_optionとアソシエショーンしていないaddress_idを許可して引っかからないようにしてあげた。
    end
end
