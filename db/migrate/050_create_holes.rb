class CreateHoles < ActiveRecord::Migration
  def change
    create_table :holes do |t|
      t.integer :round_id

      t.string :hole_number
      t.integer :score_total
      t.integer :strikes
      t.integer :putts
      t.integer :penalty
      t.string :fairway
      t.string :green
      t.string :sand
      t.string :scramble
      t.string :holepar
      t.string :holehandicap
      
      t.timestamps
    end

    add_index :holes, [:round_id]
  end
end
