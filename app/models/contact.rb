class Contact < ApplicationRecord

  belongs_to :end_user

  validates :title, presence: true, length: {in: 2..30}
  validates :body, presence: true, length: {in: 2..200}

end
