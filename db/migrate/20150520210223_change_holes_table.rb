class ChangeHolesTable < ActiveRecord::Migration
  def change
  	change_column :holes, :penalty,  :string
  	remove_column :holes, :strikes
  end
end
