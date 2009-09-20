class SearchController < ApplicationController
  def index
     @resources = Resource.find_with_index( params[:id] || params[:query], {:limit=>50}) 
      respond_to do |format|
        format.html {render :action => 'index'}
      end
  end

end
