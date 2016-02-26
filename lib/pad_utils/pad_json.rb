require 'json'

module PadUtils

  # Converts keys and sub-keys to symbols in a hash.
  #
  # Emulates Rails {http://apidock.com/rails/Hash/deep_symbolize_keys deep_symbolize_keys} method.
  #
  # @param hash [Hash] the hash to symbolize
  # @return [Hash] the symbolized hash
  # @example
  #   h = {"name": "Nico", "age": 37, "computers": [{"model": "Mac Pro"}, {"model": "MacBook"}]}
  #   PadUtils.deep_symbolize_hash_keys(h)
  #   # => {:name => "Nico", :age => 37, :computers => [{:model => "Mac Pro"}, {:model => "MacBook"}]}
  def self.deep_symbolize_hash_keys(hash)
    return hash.collect { |e| deep_symbolize_hash_keys(e) } if hash.is_a?(Array)
    return hash.inject({}) { |sh,(k,v)| sh[k.to_sym] = deep_symbolize_hash_keys(v); sh } if hash.is_a?(Hash)
    hash
  end

  # Converts a JSON string to a symbolized hash.
  #
  # Calls {PadUtils.deep_symbolize_hash_keys} on a JSON formatted string.
  #
  # @param json [String] the JSON string to convert
  # @return [Hash] the symbolized hash
  # @example
  #   PadUtils.json_to_hash(a_json_string)
  def self.json_to_hash(json)
    h = JSON.parse(json)
    self.deep_symbolize_hash_keys(h)
  end

  # Converts a JSON file to a symbolized hash.
  #
  # Reads a JSON file and calls {PadUtils.deep_symbolize_hash_keys} on its content.
  #
  # @param json_file [String] the json file path and name
  # @return [Hash] the symbolized hash
  # @example
  #   PadUtils.json_file_to_hash("path/to/file")
  def self.json_file_to_hash(json_file)
    jfile = PadUtils.get_file_content(json_file)
    h = JSON.parse(jfile)
    self.deep_symbolize_hash_keys(h)
  end

  # Convert a hash to a JSON string.
  #
  # @param hash [Hash] the hash to convert
  # @return [String] the JSON string
  # @example
  #   h = {name: "Nico", age: 37}
  #   PadUtils.hash_to_json(h) # => '{"name": "Nico", "age": 37}'
  def self.hash_to_json(hash)
    hash.to_json
  end

  # Writes a hash to a JSON file.
  #
  # @note Will overwrite the file if it already exists.
  #
  # @param filename [String] the file path and name to write to
  # @param hash [Hash] the hash to convert to JSON and write
  # @return [String] the JSON string
  # @example
  #   h = {name: "Nico", age: 37}
  #   PadUtils.hash_to_json_file("path/to/json_file.txt", h) # => '{"name": "Nico", "age": 37}'
  def self.hash_to_json_file(filename, hash)
    json = hash.to_json
    PadUtils.write_to_file(filename, json)
    json
  end

end
