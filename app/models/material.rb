class Material < ApplicationRecord
  belongs_to :post

  validates :material_name, presence: true, length: { in: 2..20 }
  validates :shop, length: { in: 2..20 }
end
