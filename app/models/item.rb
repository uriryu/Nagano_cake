class Item < ApplicationRecord
  has_one_attached :image

  has_many :cart_items, dependent: :destroy
  has_many :orders_details
  belongs_to :genre

  def with_tax_price
    (price * 1.1).floor
  end

  def self.search(keyword)
    where(['name like?', "%#{keyword}"])
  end

end
