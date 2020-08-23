class Team < ApplicationRecord
  has_many :logs, foreign_key: "team_id"
end
