class Shop < ActiveRecord::Base
  validates :url, presence: true, uniqueness: true
  attr_accessible :products_per_row
end
