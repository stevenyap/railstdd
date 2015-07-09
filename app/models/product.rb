class Product < ActiveRecord::Base
  belongs_to :category

  validates :title, :description, presence: true  
  validates :price, numericality: { greater_than: 0 }
end