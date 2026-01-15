class DropTableDemoBookS < ActiveRecord::Migration[7.0]
  def change
    drop_table :demo_books
  end
end
