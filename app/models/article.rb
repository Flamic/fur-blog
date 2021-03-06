class Article < ApplicationRecord
  include Visible

  belongs_to :user, required: true
  belongs_to :category, required: true
  has_many :comments, dependent: :destroy
  mount_uploader :picture, PictureUploader

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  validates :category_id, presence: true

  scope :starts_with, ->(search_text) { joins(:user).where('"title" LIKE ? OR "username" LIKE ?', "#{search_text}%", "#{search_text}%") }
  scope :status_or_user_is, ->(status, user) { where("status = ? OR user_id = ?", status, user) }
  scope :category_is, ->(category) { where(category_id: category) }
  
end
