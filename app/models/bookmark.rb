class Bookmark < ApplicationRecord
  belongs_to :end_user
  belongs_to :post

  default_scope -> { order(created_at: :desc) }
end
