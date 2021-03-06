class ResourcesController < ApplicationController
  def page_size
    9
  end
  
  def search
    @resources = Resource.find_with_index( params[:id] || params[:query], {:limit=>page_size})   
    @resources = @resources | Resource.find_tagged_with( params[:id] || params[:query], :limit=>page_size)
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
      @resources =  Resource.find_with_index( params[:id], {:limit=>page_size} )             
      params[:query] = params[:id]
    else
        @resources = [] 
        @resources << Resource.find_by_url_hash('2874b662') #random_selection(3)
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
    @resources = Resource.random_selection page_size, page_size        
    render :action=>'index'
  end     
  
  def latest
    @resources = Resource.find(:all, :order=>'created_at desc', :limit=>page_size)
    render :action=>'index'
  end
  
end
