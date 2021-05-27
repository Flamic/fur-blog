class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable
          #:recoverable

  validates_uniqueness_of :username
  validates :username, format: { :with => /\A\w{3,20}+\z/, :message => "only allowed letters. Length: from 3 to 20" }
end
