class Match < ApplicationRecord
  has_many :logs, dependent: :destroy
  belongs_to :school
  belongs_to :place
end
