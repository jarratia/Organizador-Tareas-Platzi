# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Category < ApplicationRecord
    has_many :categories

    #Validate presence
    validates :name, :description, presence: true

    #validate uniqueness
    validates :name, uniqueness: {case_insensitive: false}
end
