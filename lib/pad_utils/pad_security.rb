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

  # Generates a RSA private key.
  #
  # @param key_size [Integer] key size (*defaults to 2048*)
  # @param path [String] optional path to save the private key
  # @return [RSA] the RSA private key
  # @example
  #   PadUtils.generate_rsa_private_key 3096 # => <RSA key...>
  def self.generate_rsa_private_key(key_size: 2048, path: nil)
    key = OpenSSL::PKey::RSA.generate key_size
    if !path.nil?
      File.open(path, 'w') { |file| file.write(key.to_pem) }
    end
    key
  end

  # Generates a RSA public key.
  #
  # @param private_key [RSA, String] the private key as an RSA key or a pem file path
  # @param path [String] optional path to save the public key
  # @return [RSA] the RSA public key
  # @example
  #   PadUtils.generate_rsa_public_key "private.pem" # => <RSA key...>
  def self.generate_rsa_public_key(private_key: nil, path: nil)
    key = nil
    if private_key.class == OpenSSL::PKey::RSA
      key = private_key.public_key
    elsif private_key.class == String
      private_key = OpenSSL::PKey::RSA.new(File.read(private_key))
      key = PadUtils.generate_rsa_public_key private_key: private_key
    end

    if !path.nil? && !key.nil?
      File.open(path, 'w') { |file| file.write(key.to_pem) }
    end
    key
  end

  # Encrypts a string with a RSA public key.
  #
  # @param content [String] the string to encrypt
  # @param public_key [RSA, String] the public key as an RSA key or a pem file path
  # @return [String] the encrypted string
  # @example
  #   PadUtils.rsa_public_encrypt "Hello!", "public.pem" # => 'mwRAHtpE9...'
  def self.rsa_public_encrypt(content: nil, public_key: nil)
    if public_key.class == String
      public_key = OpenSSL::PKey::RSA.new(File.read(public_key))
    end

    Base64.encode64(public_key.public_encrypt(content))
  end

  # Decrypts a string with a RSA private key.
  #
  # @param content [String] the string to decrypt
  # @param public_key [RSA, String] the private key as an RSA key or a pem file path
  # @return [String] the decrypted string
  # @example
  #   PadUtils.rsa_private_decrypt "mwRAHtpE9...", "private.pem" # => 'Hello!'
  def self.rsa_private_decrypt(content: nil, private_key: nil)
    if private_key.class == String
      private_key = OpenSSL::PKey::RSA.new(File.read(private_key))
    end

    private_key.private_decrypt(Base64.decode64(content))
  end

  # Encrypts a string with a RSA private key.
  #
  # @param content [String] the string to encrypt
  # @param public_key [RSA, String] the private key as an RSA key or a pem file path
  # @return [String] the encrypted string
  # @example
  #   PadUtils.rsa_private_encrypt "Hello!", "private.pem" # => 'mwRAHtpE9...'
  def self.rsa_private_encrypt(content: nil, private_key: nil)
    if private_key.class == String
      private_key = OpenSSL::PKey::RSA.new(File.read(private_key))
    end

    Base64.encode64(private_key.private_encrypt(content))
  end

  # Decrypts a string with a RSA public key.
  #
  # @param content [String] the string to decrypt
  # @param public_key [RSA, String] the public key as an RSA key or a pem file path
  # @return [String] the decrypted string
  # @example
  #   PadUtils.rsa_public_decrypt "mwRAHtpE9...", "public.pem" # => 'Hello!'
  def self.rsa_public_decrypt(content: nil, public_key: nil)
    if public_key.class == String
      public_key = OpenSSL::PKey::RSA.new(File.read(public_key))
    end

    public_key.public_decrypt(Base64.decode64(content))
  end


end
