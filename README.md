The Storenvy Ruby Gem
====================
A Ruby wrapper for the Storenvy REST API. Initial versions cover the read-only Public JSON API


Installation
------------
    gem install storenvy
    

Usage
-------------

	client = Storenvy::Client.new("tonkapark")
	store = client.store
	puts store.url
	
	# GET First 50 Products for account
	client.products()
	
	# GET All Products
	client.products(display_all_products = true)
	
	# GET Single Page, max 50 products
	client.products(page = 2)	

	# GET Single Product
	client.product(12345)

	# GET Collections
	client.collections
	
	# GET Single Collection
	client.collection(12345)	


Supported Rubies
----------------
 * 1.8.7
 * 1.9.2


Change Log
==========

0.1.0 - August 3rd 2012
--------------
* Tweaked Client to take in the host/subdomain/account id from storenvy shop.
* Added in new methods (products, product, all_products, collections, collection) for more of the public storenvy api
* Added more tests


0.0.2 - August 2nd 2012
--------------
* just starting out.



Copyright
---------
Copyright (c) 2012 Matt Anderson, [Tonka Park](http://tonkapark.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.