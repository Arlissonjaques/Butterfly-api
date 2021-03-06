class Product < ApplicationRecord
  belongs_to :category

  validates :name, :color, :description, presence: true
end
