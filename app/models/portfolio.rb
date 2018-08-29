class Portfolio < ApplicationRecord
  has_many :trackings
  has_many :etfs, through: :trackings
end
