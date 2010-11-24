class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login, :email, :crypted_password, :password_salt, :persistence_token
      t.string :first_name, :last_name
      t.integer :account_id
      t.integer :login_count, :failed_login_count
      
      t.string :current_login_ip, :last_login_ip

      t.datetime :last_request_at, :last_login_at, :current_login_at
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
