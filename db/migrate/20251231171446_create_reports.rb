class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.references :user, null: false, foreign_key: true
      t.date :from_date
      t.date :to_date

      t.timestamps
    end
  end
end
