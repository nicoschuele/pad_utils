module PadUtils
  module Padstone

    # Prod server URL
    SERVER = "http://padstone.io/services/v1"

    # Dev server URL
    DEV_SERVER = "http://localhost:3000/services/v1"

    # Retrieves Padstone servers connection status.
    #
    # @return [Hash]
    # @example
    #   result = PadUtils::Padstone::connection_status
    #   # => {dev: :up, prod: :down}
    def self.connection_status
      result = {}
      result[:dev] = dev_connection_status
      result[:prod] = prod_connection_status
      result
    end

    # Checks if Padstone dev or prod server answers.
    #
    # @note Dev or Prod will be chosen based on `ENV['PADSTONE']` which can
    #   be `development` or `production`
    # @return [Boolean]
    # @example
    #   ENV['PADSTONE'] = 'development'
    #   PadUtils::Padstone.connected? # => true
    def self.connected?
      up = false
      if ENV['PADSTONE'] == "development"
        up = dev_connection_status == :up
      else
        up = prod_connection_status == :up
      end
      up
    end

    # Gets the connection status of the dev server.
    #
    # @return [Symbol] can be `:up` or `:down`
    # @example
    #   PadUtils::Padstone.dev_connection_status # => :up
    def self.dev_connection_status
      reply = PadUtils.http_get("#{DEV_SERVER}/connection/rick")
      if reply.nil? || reply[:message].nil? || reply[:message] != "morty"
        :down
      else
        :up
      end
    end

    # Gets the connection status of the prod server.
    #
    # @return [Symbol] can be `:up` or `:down`
    # @example
    #   PadUtils::Padstone.prod_connection_status # => :down
    def self.prod_connection_status
      reply = PadUtils.http_get("#{SERVER}/connection/rick")
      if reply.nil? || reply[:message].nil? || reply[:message] != "morty"
        :down
      else
        :up
      end
    end

  end
end
