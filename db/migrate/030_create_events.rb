class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :course_id

      t.integer :owner_id
      
      t.string :complete	
      
      t.date :playdate
      t.timestamps
    end

    add_index :events, [:course_id]
  end
end
