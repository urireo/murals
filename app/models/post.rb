class Post < ApplicationRecord
  belongs_to :user

  # destroy associated comments on article deletion
  has_many :comments, dependent: :destroy


  validates :title, presence: true
  validates :content, presence: true


end
