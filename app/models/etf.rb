class Etf < ApplicationRecord
  has_and_belongs_to_many :portfolios
  has_many :constituents, class_name: 'EtfConstituent', dependent: :destroy
end
