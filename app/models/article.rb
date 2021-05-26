class Article < ApplicationRecord
  include Visible

  belongs_to :user, required: true
  belongs_to :category, required: true
  has_many :comments, dependent: :destroy
  has_one :attachment, dependent: :destroy
  
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  validates :category_id, presence: true

  scope :starts_with, ->(search_text) { where('"title" LIKE ? OR "user_id" = ?',
                                          "#{search_text}%",
                                          User.where('"username" LIKE ?', "#{search_text}%").pluck(:id)) }
  scope :category_is, ->(category) { where(category_id: category) }
  scope :status_or_user_is, ->(status, user) { where("status = ? OR user_id = ?", status, user) }
end
