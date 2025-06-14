class Player < ApplicationRecord
  belongs_to :mlb_team

  class << self
    # Preload associated teams and iterate over them to access the team name.
    def get_players_by_preload
      preload(:mlb_team).each { |player| player.mlb_team.name }
    end

    # Eager load associated teams and iterate over them to access the team name.
    def get_players_by_eagerload
      eager_load(:mlb_team).each { |player| player.mlb_team.name }
    end
  end
end
