class Resource < ActiveRecord::Base
  acts_as_indexed :fields => [:name, :tag_list]    
  acts_as_taggable
  
  #want to set a hash that's unique despite the id
  def before_save
    self.url_hash = self.url.hash.to_s.gsub('-','').to_i.to_s(16)
  end
end                                             


