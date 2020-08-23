class School < ApplicationRecord
  has_many :match
  has_many :opponent
end
