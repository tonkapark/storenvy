require 'helper'

describe Storenvy do
  
  it "will delegate Storenvy.new to client " do
    client = Storenvy.new
    client.should be_an_instance_of Storenvy::Client   
  end
  
end


describe Storenvy::Client do

   before do

     stub_request(:get, "tonkapark.storenvy.com/store.json").
       to_return(:body=>fixture("store.json"), :headers => {:content_type => "application/json; charset=utf-8"})

  end
  
  describe "client" do
    before(:each) do
      @client = Storenvy::Client.new
    end    
      
    it "is properly classed" do           
      @client.should be_an_instance_of Storenvy::Client 
    end
    
    it "can fetch" do
      store = Storenvy::Client.fetch("http://tonkapark.storenvy.com/store.json")
      a_request(:get, "tonkapark.storenvy.com/store.json").should have_been_made          
    end    
    
  end
  
  
  describe ".store" do
    before do
      @client = Storenvy::Client.new   
    end
    
    it "with no options makes 1 http call" do
      store = @client.store("tonkapark")
      a_request(:get, "tonkapark.storenvy.com/store.json").should have_been_made   
    end 
    
    
    context "will be a valid hash" do
      before{@store = @client.store("tonkapark")}
      
      it {@store.should be_a Hash}
      
      it "should have a url" do        
        @store.url.should be_an String
        @store.url.should eq("http://tonkapark.storenvy.com")
      end

      it {@store.url.should be_a String}      
      it {@store.avatar.should be_a String}
      it {@store.subdomain.should be_a String}      
      
    end       
    
  end
  
end
