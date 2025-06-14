require 'benchmark'

class CompareLoadMethods
  class << self
    def run(size)
      prepare_data(size)
      ActiveRecord::Base.logger = Logger.new($stdout)
      measure(:player_preload) { Player.with_team_preload }
      measure(:player_eager_load) { Player.with_team_eager_load }
      measure(:team_preload) { MlbTeam.with_players_preload }
      measure(:team_eager_load) { MlbTeam.with_players_eager_load }
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
