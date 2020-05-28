class User < ApplicationRecord
  has_many :Posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :replies, dependent: :destroy
end
