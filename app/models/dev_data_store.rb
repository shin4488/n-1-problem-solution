class DevDataStore
  class << self
    def create!
      players_by_team = {
        "Dodgers" => [
          { name: "Shohei Ohtani", is_injured: false },
          { name: "Mookie Betts", is_injured: false },
          { name: "Freddie Freeman", is_injured: false },
          { name: "Walker Buehler", is_injured: false },
          { name: "Yoshinobu Yamamoto", is_injured: false }
        ],
        "Cubs" => [
          { name: "Cody Bellinger", is_injured: false },
          { name: "Dansby Swanson", is_injured: false },
          { name: "Justin Steele", is_injured: true },
          { name: "Ian Happ", is_injured: false },
          { name: "Seiya Suzuki", is_injured: true }
        ],
        "Padres" => [
          { name: "Fernando Tatis Jr.", is_injured: false },
          { name: "Juan Soto", is_injured: false },
          { name: "Manny Machado", is_injured: false },
          { name: "Yu Darvish", is_injured: false },
          { name: "Xander Bogaerts", is_injured: false }
        ],
        "Yankees" => [
          { name: "Aaron Judge", is_injured: false },
          { name: "Gerrit Cole", is_injured: false },
          { name: "Giancarlo Stanton", is_injured: true },
          { name: "DJ LeMahieu", is_injured: false },
          { name: "Anthony Volpe", is_injured: false }
        ]
      }

      players_by_team.each do |team_name, player_infos|
        team = MlbTeam.find_or_create_by!(name: team_name)

        player_infos.each do |player|
          team.players.create!(
            name: player[:name],
            is_injured: player[:is_injured]
          )
        end
      end
    end

    def create_large!
      10_000.times do |i|
        team = MlbTeam.create!(name: "Team#{i}")
        10_000.times do |j|
          team.players.create!(name: "Player#{i}_#{j}", is_injured: false)
        end
      end
    end
  end
end
