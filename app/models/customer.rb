class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items,dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy
# has_manyは複数形を記入するaddressは単数,addressesが

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :telephone_number, format: { with: /\A\d{10,11}\z/ }
  # アカウント作成時の電話番号はハイフンなしの10桁もしくは11桁のみ登録可能とするバリデーション
  validates :first_name_kana, :last_name_kana, presence: true, format: { with: /\A([ァ-ン]|ー)+\z/, message: "is must NOT contain any other characters than alphanumerics." }
  # アカウント作成時の苗字名前のカナ入力欄のカタカナのみ入力可能とするバリデーション
  validates :postal_code, format: { with: /\A\d{7}\z/ }
  # アカウント作成時の郵便番号はハイフンなしの7桁のみ登録可能とするバリデーション

  def fullname
    "%s %s"%([self.first_name, self.last_name])
  end

  def fullname_kana
    "%s %s"%([self.first_name_kana, self.last_name_kana])
  end

end
