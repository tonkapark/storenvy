require 'httparty'
require 'hashie'
    
module Storenvy

  class Client
    
    include HTTParty
    headers 'Content-Type' => 'application/json' 
    
    attr_reader :account, :host
    
    def initialize(host)
      host.gsub!(/https?:\/\//, '') # remove http(s)://    
      @account = host.include?('.') ? host.match(/^\w*/i).to_s : host 
      @host = "#{@account}.storenvy.com" # extend url to storenvy.com if no host is given       
    end
	
	
	  # GET for single resource
    def self.fetch(path)
      response = get(path)     
      case response.code
        when 200
          Hashie::Mash.new(response) 
        when 503
          {:error => "#{response.code} - Maintenance Mode"}          
        else
          {:error => response.code}
      end        
    end
    
    
    # GET when response expects multiple resources
    def self.list(path, opts={})      
      response = get(path, :query =>  {'page' => opts[:page]})           

      case response.code
        when 200
          response.map { |c| Hashie::Mash.new(c) }
        when 503
          {:error => "#{response.code} - Maintenance Mode"}          
        else
          {:error => response.code}
      end      
    end	

	
	  # GET store resource
	  def store(opts={})
	    opts = { :show_products => true }.merge opts
	    
      data = self.class.fetch("http://#{@host}/store.json")
      data.products = opts[:show_products] ?  products(true) : {}
      data
    end


    # GET Products resources, all products or single page (max 50 products per page is API limit)
    def products(display_all_products = false, page = 1)
      return all_products() if display_all_products
      return self.class.list("http://#{@host}/products.json", {:page => page})
    end
    
    def product(id)
      self.class.fetch("http://#{@host}/products/#{id}.json")
    end
    
    # GET Collections resources
    def collections
      self.class.fetch("http://#{@host}/collections.json").collections
    end    
    
    # GET Collection resource
    def collection(id)
      self.class.fetch("http://#{@host}/collections/#{id}.json")
    end    
    
    ##############################################
    ## HELPERS
  private
 
 
    # GET Products resource, pages until all products found
    def all_products
      page = 1
      products = []
      while true   
        data = self.class.list("http://#{@host}/products.json", {:page => page})
        products = (products+data).group_by{|h| h[:id]}.map{ |k,v| v.reduce(:merge)}
        page = page + 1
        break if data.count < 50
      end
      products
    end 
    
  end
end
