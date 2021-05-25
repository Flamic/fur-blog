class Category < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50 }
    has_many :articles, dependent: :destroy
end
