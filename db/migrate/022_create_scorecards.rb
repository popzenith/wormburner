class CreateScorecards < ActiveRecord::Migration
  def change
    create_table :scorecards do |t|
    	t.integer :course_id
      t.string :tee_id	
	  	t.string :course_code	
	  	t.string :tee_name	
	  	t.string :tee_color	
	  	t.string :course_par_for_tee	
	  	t.string :hole1	
	  	t.string :hole2	
	  	t.string :hole3	
	  	t.string :hole4	
	  	t.string :hole5	
	  	t.string :hole6	
	  	t.string :hole7	
	  	t.string :hole8	
	  	t.string :hole9	
	  	t.string :hole10	
	  	t.string :hole11	
	  	t.string :hole12	
	  	t.string :hole13	
	  	t.string :hole14	
	  	t.string :hole15	
	  	t.string :hole16	
	  	t.string :hole17	
	  	t.string :hole18	
	  	t.string :total_distance	
	  	t.string :hole1_par	
	  	t.string :hole2_par	
	  	t.string :hole3_par	
	  	t.string :hole4_par	
	  	t.string :hole5_par	
	  	t.string :hole6_par	
	  	t.string :hole7_par	
	  	t.string :hole8_par	
	  	t.string :hole9_par	
	  	t.string :hole10_par	
	  	t.string :hole11_par	
	  	t.string :hole12_par	
	  	t.string :hole13_par	
	  	t.string :hole14_par	
	  	t.string :hole15_par	
	  	t.string :hole16_par	
	  	t.string :hole17_par	
	  	t.string :hole18_par	
	  	t.string :hole1_handicap	
	  	t.string :hole2_handicap	
	  	t.string :hole3_handicap	
	  	t.string :hole4_handicap	
	  	t.string :hole5_handicap	
	  	t.string :hole6_handicap	
	  	t.string :hole7_handicap	
	  	t.string :hole8_handicap	
	  	t.string :hole9_handicap	
	  	t.string :hole10_handicap	
	  	t.string :hole11_handicap	
	  	t.string :hole12_handicap	
	  	t.string :hole13_handicap	
	  	t.string :hole14_handicap	
	  	t.string :hole15_handicap	
	  	t.string :hole16_handicap	
	  	t.string :hole17_handicap	
	  	t.string :hole18_handicap	
	  	t.string :rating	
	  	t.string :slope
	  
      t.timestamps
    end
    add_index :scorecards, [:created_at]
  end
end
