require 'rubygems'
require 'hpricot'   
require 'open-uri'

namespace :spider do
  desc "Spider index"
  
  "skip existing and take the first 5 pages (100 images)"
  task :update => :environment do    
    s = Spider.new true
    s.start 4020   
  end

  "Run through the whole lot, updating existing stuff also."
  task :refresh_all => :environment do    
    s = Spider.new true
    s.start 
  end          
  
  desc "Rebuild the text search index"
  task :touch => :environment do
    Resource.find :all do |r|
      r.tag_list = r.tags
      r.save!
    end
    puts "Done"
  end  
end


class Spider
  def initialize(skip_existing=true, max = 1000000)                     
    @done = []
    @max = max
    @skip_existing = skip_existing
  end
  
  def start(index=0)
    crawl_index index
  end        
  
  
  def crawl_index(offset)
    puts "Starting new page at offset #{offset}"     
    url = "http://openclipart.org/media/view/media/clip_art?offset=#{offset}"    
    doc = open(url) { |f| Hpricot(f) }
    items = doc.search("//div[@id='cc_record_listing']/div/table[@id='cc_file_info']/tr/td/h2/span/a")
    items.each do |item|
      #only skil if we're not allowing updates
      next if Resource.exists? :home_page_url => item.attributes['href'] and @skip_existing 
      resource = Resource.find(:first, :conditions=>{:home_page_url => item.attributes['href']}) || Resource.new(:name => item.inner_html, :home_page_url => item.attributes['href'])       
      puts "Following: #{item.inner_html} #{item.attributes['href']}"
      mine_page item.attributes['href'], resource       
      sleep 2
    end
    
    crawl_index(offset + 20) if items.length > 0 and offset < @max
    
  end
  
  def mine_page(url, record)              
    return if @done.include? url
    @done << url
    #image
    f = open(url)  
    f.write("  ") if f.size == 16384
    doc = Hpricot(f) 
    items = doc.search("//img[@class='cc_image_thumbnail_img']")
    record.url = nil
    items.each do |image|
      puts "Image: #{image.attributes['src']}"
      record.url = image.attributes['src']
      #tags
      #cc_tag_link

      #id
    end   
    
    #svgz don't seem to have preview images, download the mo fo
    if record.url.nil? then 
      puts "Trying to download the image."
      download_links = doc.search("//a[@id='cc_downloadbutton']")     
      record.url = open(download_links.last.attributes['href']).base_uri.to_s unless download_links.empty?        
      puts "Got #{record.url}"
    end
    

    doc.search("//td/a[@class='cc_tag_link' and @rel='tag']") do |a|
      record.tag_list.add(a.inner_html) if a.attributes['href'].include? 'tags'
    end
    record.save!                  
  end
end