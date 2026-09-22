module QueryReads
  def count_reads
    reads = 0
    subscriber = lambda do |*args|
      payload = args.last
      reads += 1 if payload[:name] != "SCHEMA" && payload[:sql].match?(/\ASELECT\b/i)
    end

    ActiveRecord::Base.uncached do
      ActiveSupport::Notifications.subscribed(subscriber, "sql.active_record") { yield }
    end
    reads
  end

  def add_more_teams_and_players
    10.times do |i|
      team = MlbTeam.create!(name: "Additional team #{i}")
      team.players.create!(name: "Additional player #{i}", is_injured: false)
    end
  end
end
