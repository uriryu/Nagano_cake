class Order < ApplicationRecord
  has_many :orders_details, dependent: :destroy
  belongs_to :customer
end
