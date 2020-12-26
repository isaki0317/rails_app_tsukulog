class Work < ApplicationRecord
  belongs_to :post

  validates :detail, presence: true, length: { in: 1..56 }

  mount_uploader :images, ImagesUploader
end
