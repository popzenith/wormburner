class AddNotifyToUser < ActiveRecord::Migration
  def change
    add_column :users, :notify, :string
  end
end
