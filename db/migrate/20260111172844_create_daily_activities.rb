class CreateDailyActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :daily_activities do |t|
      t.references :user, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.string :work_type
      t.datetime :login_at
      t.datetime :logout_at
      t.text :remarks
      t.date :activity_date
      
      t.index [:employee_id, :activity_date], unique: true
      t.timestamps
    end
    
  end
end
