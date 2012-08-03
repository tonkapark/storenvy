require 'helper'

describe Storenvy do
  
  it "will delegate Storenvy.new to client " do
    client = Storenvy.new('tonkapark')
    client.should be_an_instance_of Storenvy::Client   
  end
  
end


describe Storenvy::Client do

   before do

     stub_request(:get, "tonkapark.storenvy.com/store.json").
       to_return(:body=>fixture("store.json"), :headers => {:content_type => "application/json; charset=utf-8"})

     stub_request(:get, /tonkapark.storenvy.com\/products.json\?page=(|1)/).
       to_return(:body=>fixture("products.json"), :headers => {:content_type => "application/json; charset=utf-8"})

     stub_request(:get, /tonkapark.storenvy.com\/products.json\?page=2/).
       to_return(:body=>fixture("products_page_2.json"), :headers => {:content_type => "application/json; charset=utf-8"})
       
     stub_request(:get, /tonkapark.storenvy.com\/products\/(\d*).json/).
       to_return(:body=>fixture("product.json"), :headers => {:content_type => "application/json; charset=utf-8"})
       
     stub_request(:get, /tonkapark.storenvy.com\/collections.json/).
       to_return(:body=>fixture("collections.json"), :headers => {:content_type => "application/json; charset=utf-8"})       

     stub_request(:get, /tonkapark.storenvy.com\/collections\/(\d*).json/).
       to_return(:body=>fixture("collection.json"), :headers => {:content_type => "application/json; charset=utf-8"})       
  end
  
  describe "client" do
    
    it "properly classed" do           
      client = Storenvy::Client.new('tonkapark')
      client.should be_an_instance_of Storenvy::Client 
    end
    
    it "can fetch" do
      store = Storenvy::Client.fetch("http://tonkapark.storenvy.com/store.json")
      a_request(:get, "tonkapark.storenvy.com/store.json").should have_been_made          
    end    
 
    it "can list" do
      store = Storenvy::Client.list("http://tonkapark.storenvy.com/products.json")
      a_request(:get, "tonkapark.storenvy.com/products.json?page=").should have_been_made          
    end 
    
    context "account and host" do
      it "initializes with subdomain" do
        client = Storenvy::Client.new('tonkapark')
        client.account.should == 'tonkapark'
        client.host.should == 'tonkapark.storenvy.com'        
      end
      
      it "initializes with partial url" do
        client = Storenvy::Client.new('tonkapark.storenvy.com')
        client.account.should == 'tonkapark'
        client.host.should == 'tonkapark.storenvy.com'        
      end   
      
      it "initializes with full url" do
        client = Storenvy::Client.new('http://tonkapark.storenvy.com')
        client.account.should == 'tonkapark'
        client.host.should == 'tonkapark.storenvy.com'        
      end
      
      it "initializes with secure url" do
        client = Storenvy::Client.new('https://tonkapark.storenvy.com')
        client.account.should == 'tonkapark'
        client.host.should == 'tonkapark.storenvy.com'        
      end      
            
    end
         
    
  end
  
  
  describe ".store" do
    before do
      @client = Storenvy::Client.new("tonkapark")   
    end
    
    it "with no options makes 1 http call" do
      store = @client.store
      a_request(:get, "tonkapark.storenvy.com/store.json").should have_been_made   
    end 
    
    
    context "will be a valid hash" do
      before{@store = @client.store}
      
      it {@store.should be_a Hash}
      
      it "should have a url" do        
        @store.url.should be_an String
        @store.url.should eq("http://tonkapark.storenvy.com")
      end

      it {@store.url.should be_a String}      
      it {@store.should respond_to :avatar}
      it {@store.subdomain.should be_a String}      
      
    end       
    
  end
  
  describe ".products" do
    before do
      @client = Storenvy::Client.new("tonkapark")   
    end
    
    it "with no options should make one call" do
      products = @client.products()
      a_request(:get, "tonkapark.storenvy.com/products.json?page=1").should have_been_made   
    end
    
    it "should get specific page" do
      products = @client.products(page = 2)
      a_request(:get, "tonkapark.storenvy.com/products.json?page=2").should have_been_made   
    end
    
    context "will be a valid result" do
      before do
        @products = @client.products
        @product = @products.first
      end
      
      it {@products.should be_an Array}

      
      it {@product.id.should be_an Integer}      
      it {@product.name.should be_a String}
      it {@product.should respond_to :description}      
      it {@product.should respond_to :short_url }
      it {@product.should respond_to :price}      
      it {@product.should respond_to :status}                        
      it {@product.should respond_to :marketplace_category }                        
      it {@product.should respond_to :photos}                        
      it {@product.should respond_to :variants}   
      
    end    
    
  end
  
  describe ".product" do
    before do
      @client = Storenvy::Client.new("tonkapark")   
      @product = @client.product(468688)
    end
    
    it "should make one http call" do      
      a_request(:get, "tonkapark.storenvy.com/products/468688.json").should have_been_made   
    end
    
    
    context "will be a valid result" do
      
      it {@product.should be_a Hash}

      
      it {@product.id.should be_an Integer}      
      it {@product.name.should be_a String}
      it {@product.should respond_to :description}      
      it {@product.should respond_to :short_url }
      it {@product.should respond_to :price}      
      it {@product.should respond_to :status}                        
      it {@product.should respond_to :marketplace_category }                        
      it {@product.should respond_to :photos}                        
      it {@product.should respond_to :variants}   
      
    end    
    
  end  
  
  
  describe ".collections" do
    before do
      @client = Storenvy::Client.new("tonkapark")   
    end
    
    it "with no options should make one call" do
      products = @client.collections
      a_request(:get, "tonkapark.storenvy.com/collections.json").should have_been_made
    end
    
    context "will be a valid result" do
      before do
        @collections = @client.collections
        @collection = @collections.first
      end
      
      it {@collections.should be_an Array}

      
      it {@collection.id.should be_an Integer}      
      it {@collection.name.should be_a String}
      it {@collection.should respond_to :products} 
      it {@collection.products.should be_an Array}            
      
    end    
    
  end  
  
  describe ".collection" do
    before do
      @client = Storenvy::Client.new("tonkapark")  
      @collection = @client.collection(86385) 
    end
    
    it "with no options should make one call" do
      a_request(:get, "tonkapark.storenvy.com/collections/86385.json").should have_been_made
    end
    
    context "will be a valid result" do
      
      it {@collection.should be_a Hash}
      
      it {@collection.id.should be_an Integer}      
      it {@collection.name.should be_a String}
      it {@collection.should respond_to :products} 
      it {@collection.products.should be_an Array}            
      
    end    
    
  end  
  
  
end
