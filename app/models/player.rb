class Player < ApplicationRecord
  belongs_to :mlb_team

  class << self
    # Preload associated teams and iterate over them to access the team name.
    def with_team_preload
      preload(:mlb_team).each { |player| player.mlb_team.name }
    end

    # Eager load associated teams and iterate over them to access the team name.
    def with_team_eager_load
      eager_load(:mlb_team).each { |player| player.mlb_team.name }
    end
  end
end
