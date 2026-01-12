class AddMobileNumberToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :phone_no, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
