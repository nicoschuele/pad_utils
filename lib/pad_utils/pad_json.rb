require 'json'

module PadUtils

  # Convert all keys and sub-keys to symbols in a hash.
  # Emulates the deep_symbolize_keys found in Rails.
  # Returns a Hash.
  def self.deep_symbolize_hash_keys(hash)
    return hash.collect { |e| deep_symbolize_hash_keys(e) } if hash.is_a?(Array)
    return hash.inject({}) { |sh,(k,v)| sh[k.to_sym] = deep_symbolize_hash_keys(v); sh } if hash.is_a?(Hash)
    hash
  end

  # Convert a JSON string to a symbolized hash.
  # Returns a hash.
  def self.json_to_hash(json)
    h = JSON.parse(json)
    self.deep_symbolize_hash_keys(h)
  end

  # Load a JSON file and convert it to a symbolized hash.
  # Returns a hash.
  def self.json_file_to_hash(json_file)
    jfile = PadUtils.get_file_content(json_file)
    h = JSON.parse(jfile)
    self.deep_symbolize_hash_keys(h)
  end

  # Convert a hash to JSON. Alias method for consistency.
  # Returns a string
  def self.hash_to_json(hash)
    hash.to_json
  end

  # Write a hash to a json file.
  # Returns the file content as a string.
  def self.hash_to_json_file(filename, hash)
    json = hash.to_json
    PadUtils.write_to_file(filename, json)
    json
  end


end
