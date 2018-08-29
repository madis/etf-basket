class Etf < ApplicationRecord
  has_many :trackings
  has_many :portfolios, through: :trackings
  has_many :constituents, class_name: 'EtfConstituent', dependent: :destroy
end
