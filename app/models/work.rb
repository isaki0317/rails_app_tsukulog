class Work < ApplicationRecord

  belongs_to :post

  mount_uploader :images, ImagesUploader

end
