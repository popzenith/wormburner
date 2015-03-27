class CreateHoles < ActiveRecord::Migration
  def change
    create_table :holes do |t|
      t.integer :round_id

      t.integer :hole_number
      t.integer :score_total
      t.integer :score_total_esc
      t.integer :strikes
      t.integer :putts
      t.integer :penalty
      t.string :fairway
      t.string :green
      t.string :sand
      t.string :scramble
      t.integer :holepar
      t.integer :holehandicap
      
      t.timestamps
    end

    add_index :holes, [:round_id]
  end
end
