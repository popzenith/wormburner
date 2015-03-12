class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :course_id
      
      t.string :complete
      		
      t.timestamps
    end

    add_index :reservations, [:user_id, :course_id]
  end
end
