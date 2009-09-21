class ResourcesController < ApplicationController
  
  def search
    @resources = Resource.find_with_index( params[:id] || params[:query], {:limit=>20})   
    @resources = @resources | Resource.find_tagged_with( params[:id] || params[:query])
    params[:query]= params[:id]
    respond_to do |format|
      format.html {render :action => 'index'}
    end
  end            
  
  def tag_cloud
    @tags = Resource.tag_counts
  end          

  def index 
    
    if not params[:id].nil? then
      @resources =  Resource.find_with_index( params[:id], {:limit=>20} )             
      params[:query] = params[:id]
    else
        #@resources = Resource.find(:all, :conditions=>{:hot_topic=>'show_off'}, :offset=>0, :limit=>20, :order=>'created_at asc')
#        favored = ['yoga','characters','roadsign','painting','spice','chess']
 #       tag = favored[rand(favored.length)]
        @resources = [] #Resource.find_with_index('characters', {:limit=>3, :order=>'name'})      
        
    end
    
    @resource_count = Resource.count
        
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @resources }
    end
  end

  def show
    @resource = Resource.find_by_url_hash(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @resource }
    end
  end 
             
  def random        
    tag = Tag.find :first, :offset=>rand(Tag.count)
    @resources = Resource.find_tagged_with(tag.to_s)
    params[:query] = tag.to_s
    render :action=>'index'
  end
  
end
