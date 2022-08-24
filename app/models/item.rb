class Item < ApplicationRecord
  has_one_attached :image

  has_many :cart_items, dependent: :destroy
  has_many :orders_details #消えたらこまるので、dependentは書いていない。
  belongs_to :genre

  validates :name, presence: true
  validates :introduction, presence: true
  validates :genre_id, presence: true
  # 値段設定時、半角数字のみ登録可能にするバリデーション
  validates :price, presence: true, format: {
    with: /\A[0-9]+\z/i,
  }

  def with_tax_price
    (price * 1.1).floor
  end

  def self.search(keyword)
    where(['name like?', "%#{keyword}"])
  end

end
