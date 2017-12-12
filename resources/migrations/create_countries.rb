class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries, primary_key: :code, id: :string, limit: 2, force: :cascade do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :countries
  end
end
