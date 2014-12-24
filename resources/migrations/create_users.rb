class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
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
      t.integer   :state_id
      t.integer   :country_id

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :users
  end
end
