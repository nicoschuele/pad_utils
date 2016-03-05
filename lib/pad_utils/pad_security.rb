require 'base64'
require 'uri'
require 'openssl'
require 'digest/sha1'

module PadUtils

  # Encrypts a string.
  #
  # @param content [String] the content to encrypt
  # @param key [String] the encryption key
  # @return [String] the encrypted string
  # @example
  #   PadUtils.encrypt("Hello", "s3cr3t") # => 'DKBJVYG69YsAWT%0A__1f346a8eeedc7'
  def self.encrypt(content: "", key: "")
    cipher = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
    cipher.encrypt

    iv = PadUtils.uuid.gsub("-", "")

    key = Digest::SHA1.hexdigest(key)

    cipher.key = key
    cipher.iv = iv

    encrypted = '' << cipher.update(content) << cipher.final

    encrypted = Base64.encode64(encrypted)
    encrypted = URI.escape(encrypted, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))

    encrypted = "#{encrypted}__#{iv}"

  rescue
    encrypted = "invalid"
  end

  # Decrypts a string.
  #
  # @param content [String] the encrypted string
  # @param key [String] the encryption key
  # @return [String] the decrypted string
  # @example
  #   PadUtils.decrypt("DKBJVYG69YsAWT%0A__1f346a8eeedc7", "s3cr3t") # => 'Hello'
  def self.decrypt(content: "", key: "")
    cipher = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
    cipher.decrypt

    key = Digest::SHA1.hexdigest(key)

    iv = content.split("__")[1]
    content = content.split("*+*")[0]

    cipher.key = key
    cipher.iv = iv

    content = URI.unescape(content)
    content = Base64.decode64(content)

    decrypted = '' << cipher.update(content) << cipher.final

    decrypted

  rescue
    decrypted = "invalid"
  end

end
