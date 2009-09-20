class AddHashToResources < ActiveRecord::Migration
  def self.up  
    add_column :resources, :url_hash, :string
  end

  def self.down                          
    remove_column :resources, :url_hash
  end
end
