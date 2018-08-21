class Portfolio < ApplicationRecord
  has_and_belongs_to_many :etfs
end
