class Article < ApplicationRecord
  include Visible

  belongs_to :category, required: true
  has_many :comments, dependent: :destroy
  has_one_attached :picture, dependent: :destroy
  
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  validates :category_id, presence: true

  scope :starts_with, ->(title) { where('"title" LIKE ?', "#{title}%") }
  scope :category_is, ->(category) { where(category_id: category) }
end
