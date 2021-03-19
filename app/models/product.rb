# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  color       :string
#  category_id :integer          not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Product < ApplicationRecord
  belongs_to :category

  validates :name, :color, :description, presence: true
end
