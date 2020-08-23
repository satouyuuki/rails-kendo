class Log < ApplicationRecord
  belongs_to :team, foreign_key: "team_id"
  belongs_to :opponent
  belongs_to :match
end
