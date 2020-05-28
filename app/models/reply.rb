class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates :content, presence: true
  validates :comment_id, presence: true
  validates :user_id, presence: true
end
