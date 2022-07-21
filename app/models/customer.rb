class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items,dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy
# has_manyは複数形を記入するaddressは単数,addressesが

  enum is_deleted: {"退会": true, "有効": false, }
end
