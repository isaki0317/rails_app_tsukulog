class Comment < ApplicationRecord
  belongs_to :end_user
  belongs_to :post

  validates :body, presence: true, length: { maximum: 50 }

  default_scope -> { order(created_at: :desc) }
end
