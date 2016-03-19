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
  # @param headers [Hash] the hash containing the header key/value pairs
  # @return [Hash] the response as a hash
  # @example
  #   url = "http://example.com/api/movies"
  #   body = {year: 2008, director: "Nolan"}
  #   PadUtils.http_post(url: url, body: body) # => {movie: "The Dark Knight"}
  def self.http_post(url: "", body: {}, headers: {'User-Agent' => 'Padstone'})
    reply_hash = {}
    body = PadUtils.hash_to_json(body)
    reply = HTTParty.post(url, {headers: headers, body: body}).to_s
    reply_hash = PadUtils.json_to_hash reply
    reply_hash
  rescue JSON::ParserError => e
    reply_hash = {error: "Response is not JSON"}
  rescue Errno::ECONNREFUSED => e
    reply_hash = {error: "Server unreachable"}
  rescue Exception => e
    reply_hash = {error: e.message}
  end

  # Sends a HTTP GET request and receives plain text.
  #
  #
  # If the server can't be reached, `"Server unreachable"` is returned.
  #
  # @param url [String] the url to call
  # @param headers [Hash] the hash containing the header key/value pairs
  # @return [String] the response
  # @example
  #   url = "http://example.com/api/joke"
  #   PadUtils.http_get_plain(url) # => "There are 10 kinds of programmers."
  def self.http_get_plain(url, headers: {'User-Agent' => 'Padstone'})
    reply = HTTParty.get(url, headers: headers).to_s
  rescue Errno::ECONNREFUSED => e
    reply = "Server unreachable"
  rescue Exception => e
    reply = e.message
  end

  # Sends a HTTP GET request and receives a hash.
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
  # @param headers [Hash] the hash containing the header key/value pairs
  # @return [Hash] the response as a hash
  # @example
  #   url = "http://example.com/api/weather"
  #   PadUtils.http_get(url) # => {Geneva: "Sunny", Lausanne: "Cloudy"}
  def self.http_get(url, headers: {'User-Agent' => 'Padstone'})
    reply_hash = {}
    reply = HTTParty.get(url, headers: headers).to_s
    reply_hash = PadUtils.json_to_hash reply
    reply_hash
  rescue JSON::ParserError => e
    reply_hash = {error: "Response is not JSON"}
  rescue Errno::ECONNREFUSED => e
    reply_hash = {error: "Server unreachable"}
  rescue Exception => e
    reply_hash = {error: e.message}
  end

  # Downloads a file API-frienldy.
  #
  # @note **Warning:** If the server answers with an error message, no error will
  #   be raised and the `target` file be created with the content of the error message.
  #
  # @param url [String]
  # @param target [String] the local target file path and name
  # @param headers [Hash] the hash containing the header key/value pair
  # @return [String] the target path and name or the error message
  # @example
  #   PadUtils.http_get_file("http:/example.com/v1/get_file", "image.jpg") # => "image.jpg"
  def self.http_get_file(url, target, headers: {'User-Agent' => 'Padstone'})
    File.open(target, "wb") do |f|
      f.binmode
      f.write HTTParty.get(url).parsed_response
    end

    if File.size(target) < 1
      PadUtils.delete_file(target)
      "File not found"
    else
      target
    end

  rescue Errno::ECONNREFUSED => e
    PadUtils.delete_file(target)
    "Server unreachable"
  rescue Exception => e
    PadUtils.delete_file(target)
    e.message
  end

end
