class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string    :email,               :null => false                # optional, you can use login instead, or both
      t.string    :crypted_password,    :null => false                # optional, see below
      t.string    :password_salt,       :null => false                # optional, but highly recommended
      t.string    :persistence_token,   :null => false                # required
      t.string    :perishable_token,    :null => false                # optional, see Authlogic::Session::Perishability
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
  end

  def self.down
    drop_table :users
  end
end
