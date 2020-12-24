class Genre < ApplicationRecord
  has_many :posts

  validates :name, presence: true, length: { in: 1..12 }, uniqueness: true
end
