class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :event_id
      t.integer :user_id
      t.integer :scorecard_id

      t.string :tee
      t.integer :hol
      t.integer :score_front
      t.integer :score_back
      t.integer :score_total
      t.integer :course_handicap
      t.integer :score_total_adj
      t.float :handicap_differential
      t.string :complete
      t.string :score_type
      
      t.date :playdate
      t.timestamps
    end

    add_index :rounds, [:event_id]
  end
end
