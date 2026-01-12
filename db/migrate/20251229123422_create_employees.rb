class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.string :work_type
      t.date :last_active

      t.timestamps
    end
  end
end
