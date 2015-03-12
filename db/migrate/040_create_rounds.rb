class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :event_id
      t.integer :user_id
      t.integer :scorecard_id

      t.string :tee
      t.integer :score_front
      t.integer :score_back
      t.integer :score_total
      t.string :handicap_used
      t.string :complete
      
      t.date :playdate
      t.timestamps
    end

    add_index :rounds, [:event_id]
  end
end
