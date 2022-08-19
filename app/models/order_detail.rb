class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  def with_tax_price
    (price.to_i * 1.1).floor
  end

  def subtotal
    (with_tax_price * amount).floor
  end

    enum making_status: { cannot: 0, waiting: 1, making: 2, complete: 3}

end
