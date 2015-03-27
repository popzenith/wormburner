class CreateScorecards < ActiveRecord::Migration
  def change
    create_table :scorecards do |t|
    	t.integer :course_id
      t.string :tee_id	
	  	t.string :course_code	
	  	t.string :tee_name	
	  	t.string :tee_color	
	  	t.integer :course_par_for_tee	
	  	t.integer :hole1	
	  	t.integer :hole2	
	  	t.integer :hole3	
	  	t.integer :hole4	
	  	t.integer :hole5	
	  	t.integer :hole6	
	  	t.integer :hole7	
	  	t.integer :hole8	
	  	t.integer :hole9	
	  	t.integer :hole10	
	  	t.integer :hole11	
	  	t.integer :hole12	
	  	t.integer :hole13	
	  	t.integer :hole14	
	  	t.integer :hole15	
	  	t.integer :hole16	
	  	t.integer :hole17	
	  	t.integer :hole18	
	  	t.integer :total_distance	
	  	t.integer :hole1_par	
	  	t.integer :hole2_par	
	  	t.integer :hole3_par	
	  	t.integer :hole4_par	
	  	t.integer :hole5_par	
	  	t.integer :hole6_par	
	  	t.integer :hole7_par	
	  	t.integer :hole8_par	
	  	t.integer :hole9_par	
	  	t.integer :hole10_par	
	  	t.integer :hole11_par	
	  	t.integer :hole12_par	
	  	t.integer :hole13_par	
	  	t.integer :hole14_par	
	  	t.integer :hole15_par	
	  	t.integer :hole16_par	
	  	t.integer :hole17_par	
	  	t.integer :hole18_par	
	  	t.integer :hole1_handicap	
	  	t.integer :hole2_handicap	
	  	t.integer :hole3_handicap	
	  	t.integer :hole4_handicap	
	  	t.integer :hole5_handicap	
	  	t.integer :hole6_handicap	
	  	t.integer :hole7_handicap	
	  	t.integer :hole8_handicap	
	  	t.integer :hole9_handicap	
	  	t.integer :hole10_handicap	
	  	t.integer :hole11_handicap	
	  	t.integer :hole12_handicap	
	  	t.integer :hole13_handicap	
	  	t.integer :hole14_handicap	
	  	t.integer :hole15_handicap	
	  	t.integer :hole16_handicap	
	  	t.integer :hole17_handicap	
	  	t.integer :hole18_handicap	
	  	t.float :rating	
	  	t.float :slope
	  
      t.timestamps
    end
    add_index :scorecards, [:created_at]
  end
end
