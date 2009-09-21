# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper                                                             
   include TagsHelper
   
   def cool_searches
     ['emoticon', 'file', 'nature', 'character', 'shield', 'lego', 'sexy',  'car', 'furniture', 'photorealistic', 'kitchen', 'roadsign','clock', 'isometric']
   end
end                                                


