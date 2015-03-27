class AddNotifyToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :notify, :string
    add_column :users, :handicap, :float
    add_column :users, :buddy, :string
    add_column :users, :gender, :string
  end
end
