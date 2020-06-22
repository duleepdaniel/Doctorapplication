class AddUserToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :user_id, :integer
  end
end
