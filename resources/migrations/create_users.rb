class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable

      t.string    :email,               :null => false
      t.string    :first_name
      t.string    :last_name
      t.boolean   :active,              :default => true
      t.datetime  :confirmed_at
      t.string    :time_zone
      t.string    :phone_number
      t.string    :company_name
      t.string    :title
      t.string    :address_line_1
      t.string    :address_line_2
      t.string    :city
      t.string    :postal_code
      t.integer   :state_id
      t.integer   :country_id

      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end

  def self.down
    drop_table :users
  end
end
