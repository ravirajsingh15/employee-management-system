class AddDepartmentAndWorkTypeColumnToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :work_type, :string
    add_column :reports, :department, :string
  end
end
