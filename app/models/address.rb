class Address < ApplicationRecord
  belongs_to :customer
  # belongs_toは単数形を書く!忘れないこと!
  # アソシエーションを結ぶときは必ずbelongs_to has_manyはそれぞれに記入すること

  validates :postal_code, format: { with: /\A\d{7}\z/ }
  # アカウント作成時の郵便番号はハイフンなしの7桁のみ登録可能とするバリデーション

  def address_display
    '〒' + postal_code + '' + address + ' ' + name
  end

end