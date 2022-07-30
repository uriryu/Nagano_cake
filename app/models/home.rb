class Home < ApplicationRecord
  
  has_many :items, dependent: :destroy
  has_many :genres, dependent: :destroy
end
