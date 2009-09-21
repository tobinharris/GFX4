class Resource < ActiveRecord::Base
  acts_as_indexed :fields => [:name, :tag_list]    
  acts_as_taggable
   
  def self.random_tag
    Tag.find :first, :offset=>rand(Tag.count)  
  end
  
  def self.random_selection(max=20, min=0)
     tag = Resource.random_tag
     resources = Resource.find_tagged_with(tag.to_s, :limit=>max)
     
     attempts = 0
     while resources.length < max and attempts < 3
       attempts = attempts + 1
       resources = resources | Resource.random_selection(max - resources.length)
     end                       
     
     resources
  end
  
  
  #want to set a hash that's unique despite the id
  def before_save
    self.url_hash = self.url.hash.to_s.gsub('-','').to_i.to_s(16)
  end
end                                             


