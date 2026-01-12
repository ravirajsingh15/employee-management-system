class AddMultipleColumnToEmployee < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :department, :string
    add_column :employees, :designation, :string
    add_column :employees, :joining_date, :date
    add_column :employees, :salary, :integer
  end
end
