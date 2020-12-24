class Notification < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  belongs_to :visitor, class_name: 'EndUser', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'EndUser', foreign_key: 'visited_id', optional: true
  # トーク機能への通知↓
  belongs_to :room, optional: true
  belongs_to :chat, optional: true
  default_scope -> { order(created_at: :desc) }
end
