class Match < ApplicationRecord
  has_many :logs
  belongs_to :school
  belongs_to :place
end
