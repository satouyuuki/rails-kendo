class Log < ApplicationRecord
  belongs_to :team
  belongs_to :opponent
  belongs_to :match
end
