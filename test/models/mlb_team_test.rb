require "test_helper"
require_relative "../support/query_reads"

class MlbTeamTest < ActiveSupport::TestCase
  include QueryReads

  %i[get_teams_by_preload get_teams_by_eagerload].each do |loader|
    test "#{loader} returns every team including teams without players" do
      rows = MlbTeam.public_send(loader).map do |team|
        [ team.name, team.players.map(&:name).sort ]
      end

      assert_equal [ [ "Empty", [] ], [ "North", [ "Alex", "Blair" ] ], [ "South", [ "Alex" ] ] ], rows.sort
    end

    test "#{loader} returns no teams for an empty dataset" do
      Player.delete_all
      MlbTeam.delete_all

      assert_empty MlbTeam.public_send(loader).to_a
    end

    test "#{loader} does not add database reads for each additional team" do
      MlbTeam.public_send(loader).each { |team| team.players.map(&:name) }
      baseline = count_reads { MlbTeam.public_send(loader).each { |team| team.players.map(&:name) } }

      add_more_teams_and_players
      expanded = count_reads { MlbTeam.public_send(loader).each { |team| team.players.map(&:name) } }

      assert_operator baseline, :>, 0
      assert_operator expanded, :<=, baseline
    end
  end
end
