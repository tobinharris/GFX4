class CreateResources < ActiveRecord::Migration
  def self.up
    create_table :resources do |t|
      t.string :name
      t.string :url
      t.string :type
      t.string :home_page_url
      t.timestamps
    end
  end

  def self.down
    drop_table :resources
  end
end
