require 'httparty'
require 'json'
module PadUtils

  # Sends a HTTP POST request.
  #
  # @note Although it can parse any JSON responses, this method is made to work
  #   in conjunction with PadUtils on the server side code.
  #
  # If the server can't be reached, `{error: "Server unreachable"}` is returned.
  #
  # If the JSON in the response can't be parsed (or if it's not JSON),
  #   `{error: "Response is not JSON"}` is returned.
  #
  # @param url [String] the url to call
  # @param body [Hash] the hash containing the key/value pairs to send
  # @param header [Hash] the hash containing the header key/value pairs
  # @return [Hash] the response as a hash
  # @example
  #   url = "http://example.com/api/movies"
  #   body = {year: 2008, director: "Nolan"}
  #   PadUtils.http_post(url: url, body: body) # => {movie: "The Dark Knight"}
  def self.http_post(url: "", body: {}, header: {'Content-Type' => 'application/json'})
    reply_hash = {}
    body = PadUtils.hash_to_json(body)
    reply = HTTParty.post(url, {header: header, body: body})
    reply_hash = PadUtils.json_to_hash reply
    reply_hash
  rescue JSON::ParserError => e
    reply_hash = {error: "Response is not JSON"}
  rescue Errno::ECONNREFUSED => e
    reply_hash = {error: "Server unreachable"}
  rescue Exception => e
    reply_hash = {error: e.message}
  end

end
