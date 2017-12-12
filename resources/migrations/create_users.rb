class CreateUsers < ActiveRecord::Migration
  def self.up
    enable_extension "uuid-ossp"

    create_table :users, id: :uuid, default: "uuid_generate_v4()" do |t|
      t.string    :first_name
      t.string    :last_name
      t.boolean   :active,              default: true
      t.integer   :roles_mask
      t.string    :time_zone
      t.string    :phone_number
      t.string    :company_name
      t.string    :title
      t.string    :address_line_1
      t.string    :address_line_2
      t.string    :city
      t.string    :postal_code
      t.string    :state_id, limit: 4
      t.string    :country_code, limit: 2

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :users
  end
end
