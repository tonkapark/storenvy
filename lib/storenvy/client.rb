require 'httparty'
require 'hashie'
    
module Storenvy

  class Client
    
    include HTTParty
    headers 'Content-Type' => 'application/json' 

	def initialize(options={})
	end
	
    def self.fetch(path)
      response = get(path)     
      Hashie::Mash.new(response)  
    end
    
    def self.list(path, opts={})      
      response = get(path, :query =>  {'limit' => opts[:limit]})           
      response.map { |c| Hashie::Mash.new(c)}
    end	
	
      
    ##############################################
    ## HELPERS
  private
 
    
  end
end
