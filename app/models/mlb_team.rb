class MlbTeam < ApplicationRecord
  has_many :players, dependent: :destroy

  class << self
    # Preload associated players and iterate over them to access player names.
    def with_players_preload
      preload(:players).each { |team| team.players.each(&:name) }
    end

    # Eager load associated players and iterate over them to access player names.
    def with_players_eager_load
      eager_load(:players).each { |team| team.players.each(&:name) }
    end
  end
end
