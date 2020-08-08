class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states, id: :string, limit: 4, force: :cascade do |t|
      t.string :country_code, limit: 2
      t.string :code, limit: 2
      t.string :name
    end
  end

  def self.down
    drop_table :states
  end
end
