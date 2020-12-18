class Comment < ApplicationRecord

  belongs_to :end_user
  belongs_to :post

  validates :body, presence: true, length: {in: 1..60}

  default_scope -> { order(created_at: :desc) }

end
