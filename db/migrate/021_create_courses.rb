class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
    	t.integer :facility_id
      t.string :course_code	
	  	t.string :facility_code	
	  	t.string :course_name	
	  	t.string :hol
	  	t.string :par	
	  	t.string :course_type	
	  	t.string :course_architect	
	  	t.string :open_date	
	  	t.string :guest_policy	
	  	t.string :weekday_price	
	  	t.string :weekend_price	
	  	t.string :twilight_price	
	  	t.string :fairway	
	  	t.string :green	
	  	t.string :currency
	  
      t.timestamps
    end
    add_index :courses, [:created_at]
  end
end
