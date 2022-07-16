class Item < ApplicationRecord
  has_one_attached :image

  has_many :cart_items, dependent: :destroy
  has_many :orders_details, dependent: :destroy
  belongs_to :genre

  enum is_active: { "販売中": true, "販売停止中": false }

  def with_tax_price
    (price * 1.1).floor
  end

end
