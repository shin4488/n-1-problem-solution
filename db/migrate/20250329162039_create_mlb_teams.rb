class CreateMlbTeams < ActiveRecord::Migration[7.2]
  def change
    create_table :mlb_teams, comment: 'MLBのチーム' do |t|
      t.string :name, comment: 'チーム名'

      t.timestamps
    end
  end
end
