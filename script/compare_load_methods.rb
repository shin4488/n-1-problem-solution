require 'benchmark'

class CompareLoadMethods
  class << self
    def run(size)
      prepare_data(size)
      ActiveRecord::Base.logger = Logger.new($stdout)
      measure(:player_preload) { Player.get_players_by_preload }
      measure(:player_eager_load) { Player.get_players_by_eagerload }
      measure(:team_preload) { MlbTeam.get_teams_by_preload }
      measure(:team_eager_load) { MlbTeam.get_teams_by_eagerload }
    end

    private

    def prepare_data(size)
      Player.delete_all
      MlbTeam.delete_all

      if size == :large
        DevDataStore.create_large!
      else
        DevDataStore.create!
      end
    end

    def measure(label)
      time = Benchmark.realtime { yield }
      puts "#{label}: #{time.round(3)}s"
    end
  end
end

size = (ARGV[0] || 'small').to_sym
CompareLoadMethods.run(size)
