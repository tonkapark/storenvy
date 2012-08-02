require 'storenvy/client'

module Storenvy
  class << self
    # Alias for Storenvy::Client.new
    #
    # @return [Storenvy::Client]
    def new(options={})
      Storenvy::Client.new(options)
    end

    # Delegate to Storenvy::Client
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end
