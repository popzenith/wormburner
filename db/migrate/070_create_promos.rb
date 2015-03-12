class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.integer :user_id
      t.integer :course_id
     
      t.string :content
      t.string :link
      
      t.string :photo_file_name
	  t.string :photo_content_type
	  t.integer :photo_file_size
	  t.datetime :photo_updated_at
      		
      t.timestamps
    end

    add_index :promos, [:user_id]
  end
end
