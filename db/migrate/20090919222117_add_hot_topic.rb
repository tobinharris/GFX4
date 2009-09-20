class AddHotTopic < ActiveRecord::Migration
  def self.up
    add_column :resources, :hot_topic, :string
  end

  def self.down
    remove_column :resources, :hot_topic
  end
end
