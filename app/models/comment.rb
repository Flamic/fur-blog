class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user

  validates_presence_of :body
end
