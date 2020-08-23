class Opponent < ApplicationRecord
  has_many :logs
  belongs_to :school
end
