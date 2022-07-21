class Address < ApplicationRecord
  belongs_to :customer
  # belongs_toは単数形を書く!忘れないこと!
  # アソシエーションを結ぶときは必ずbelongs_to has_manyはそれぞれに記入すること
end
