class Category < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50 }
    has_many :articles, dependent: :destroy

    #scope :category_by_name, ->(category) { where("name = ?", category).first }
end
