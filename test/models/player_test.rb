require "test_helper"
require_relative "../support/query_reads"

class PlayerTest < ActiveSupport::TestCase
  include QueryReads

  %i[get_players_by_preload get_players_by_eagerload].each do |loader|
    test "#{loader} returns every player with the correct team and injury status" do
      rows = Player.public_send(loader).map do |player|
        [ player.name, player.mlb_team.name, player.is_injured ]
      end

      assert_equal [ [ "Alex", "North", false ], [ "Alex", "South", true ], [ "Blair", "North", false ] ], rows.sort
    end

    test "#{loader} returns no players for an empty dataset" do
      Player.delete_all

      assert_empty Player.public_send(loader).to_a
    end

    test "#{loader} does not add database reads for each additional player" do
      # Warm schema metadata before measuring; compare growth, not exact SQL or counts.
      Player.public_send(loader).map { |player| player.mlb_team.name }
      baseline = count_reads { Player.public_send(loader).map { |player| player.mlb_team.name } }

      add_more_teams_and_players
      expanded = count_reads { Player.public_send(loader).map { |player| player.mlb_team.name } }

      assert_operator baseline, :>, 0
      assert_operator expanded, :<=, baseline
    end
  end
end
