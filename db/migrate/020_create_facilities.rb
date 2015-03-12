class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.string :facility_code	
	  	t.string :facility_name	
	  	t.string :club_membership	
	  	t.string :number_of_holes	
	  	t.string :address	
	  	t.string :city	
	  	t.string :state	
	  	t.string :country	
	  	t.string :postal_code	
	  	t.string :phone	
	  	t.string :fax	
	  	t.string :website	
	  	t.float :longitude	
	  	t.float :latitude	
	  	t.string :contact_name	
	  	t.string :contact_title	
	  	t.string :email_address	
	  	t.string :driving_range	
	  	t.string :putting_green	
	  	t.string :chipping_green	
	  	t.string :practice_bunker	
	  	t.string :motor_cart	
	  	t.string :pull_cart	
	  	t.string :golf_clubs_rental	
	  	t.string :club_fitting	
	  	t.string :pro_shop	
	  	t.string :golf_lessons	
	  	t.string :caddie_hire	
	  	t.string :restaurant	
	  	t.string :reception_hall	
	  	t.string :changing_room	
	  	t.string :lockers	
	  	t.string :lodging_on_site
	  
      t.timestamps
    end
    add_index :facilities, [:created_at]
  end
end
