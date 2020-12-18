class Work < ApplicationRecord

  belongs_to :post

  validates :detail, presence: true, length: {in: 2..56}

  mount_uploader :images, ImagesUploader

end
