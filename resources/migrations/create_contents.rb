class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|
      t.string :name
      t.string :slug
      t.string :title
      t.text :html
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :contents
  end
end
