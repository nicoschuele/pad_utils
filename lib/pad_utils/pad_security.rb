require 'base64'
require 'uri'
require 'openssl'
require 'digest/sha1'

module PadUtils

  # def self.encrypt(content: "", key: "", iv: "7478110410030520")
  #   cipher = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
  #   cipher.encrypt
  #
  #   key = Digest::SHA1.hexdigest(key)
  #
  #   cipher.key = key
  #   cipher.iv = iv
  #
  #   encrypted = '' << cipher.update(content) << cipher.final
  #
  #   encrypted = Base64.encode64(encrypted)
  #   encrypted = URI.escape(encrypted, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
  #
  #   encrypted
  #
  # rescue
  #   encrypted = "invalid"
  # end
  #
  # def self.decrypt(content: "", key: "", iv: "7478110410030520")
  #   cipher = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
  #   cipher.decrypt
  #
  #   key = Digest::SHA1.hexdigest(key)
  #
  #   cipher.key = key
  #   cipher.iv = iv
  #
  #   content = URI.unescape(content)
  #   content = Base64.decode64(content)
  #
  #   decrypted = '' << cipher.update(content) << cipher.final
  #
  #
  #   decrypted
  #
  # rescue
  #   decrypted = "invalid"
  # end

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
