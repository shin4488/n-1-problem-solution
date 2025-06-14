class CreatePlayers < ActiveRecord::Migration[7.2]
  def change
    create_table :players, comment: '選手' do |t|
      t.references :mlb_team, null: false, foreign_key: true, comment: '所属チーム'
      t.string :name, comment: '選手名'
      t.boolean :is_injured, comment: '故障者であるか否か（故障者であればtrue）'

      t.timestamps
    end
  end
end
