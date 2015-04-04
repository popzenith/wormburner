class AddAttachmentPhotoToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :photo_file_name, :string
		add_column :users, :photo_content_type, :string
		add_column :users, :photo_file_size, :integer
		add_column :users, :photo_updated_at, :datetime
		add_column :users, :pdf_file_name, :string
		add_column :users, :pdf_content_type, :string
		add_column :users, :pdf_file_size, :integer
		add_column :users, :pdf_updated_at, :datetime
  end

  def self.down
    remove_column :users, :photo_file_name
		remove_column :users, :photo_content_type
		remove_column :users, :photo_file_size
		remove_column :users, :photo_updated_at
		remove_column :users, :pdf_file_name
		remove_column :users, :pdf_content_type
		remove_column :users, :pdf_file_size
		remove_column :users, :pdf_updated_at
  end
end
