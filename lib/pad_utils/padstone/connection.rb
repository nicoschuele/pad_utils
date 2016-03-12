module PadUtils
  module Padstone
    SERVER = "http://padstone.io/services/v1"
    DEV_SERVER = "http://localhost:3000/services/v1"

    def self.connection_status
      result = {}
      result[:dev] = dev_connection_status
      result[:prod] = prod_connection_status
      result
    end

    def self.connected?
      up = false
      if ENV['PADSTONE'] == "development"
        up = dev_connection_status == :up
      else
        up = prod_connection_status == :up
      end
      up
    end

    def self.dev_connection_status
      reply = PadUtils.http_get("#{DEV_SERVER}/connection/rick")
      if reply.nil? || reply[:message].nil? || reply[:message] != "morty"
        :down
      else
        :up
      end
    end

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
