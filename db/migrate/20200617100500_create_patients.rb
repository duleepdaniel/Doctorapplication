class CreatePatients < ActiveRecord::Migration[5.2]
  def change
    create_table :patients do |t|
    	t.string :name
    	t.integer :age
    	t.string :email
    	t.text :address
    	t.text :details
      t.date :date

      t.timestamps
    end
  end
end
