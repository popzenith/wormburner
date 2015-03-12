class AddNotifyToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :notify, :string
    add_column :users, :handicap, :string
    add_column :users, :buddy, :string
  end
end
