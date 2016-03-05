require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "Encrypt"

class EncryptTest < Test

  def prepare
    # Add test preparation here
  end

  def run_test
    original = "This should be encrypted"
    key = "s3cr3t"
    encrypted = PadUtils.encrypt(content: original, key: key)
    encrypted_again = PadUtils.encrypt(content: original, key: key)

    PadUtils.puts_c encrypted, :blue
    PadUtils.puts_c encrypted_again, :blue

    decrypted = PadUtils.decrypt(content: encrypted, key: key)
    decrypted_again = PadUtils.decrypt(content: encrypted_again, key: key)

    if original != decrypted && original != decrypted_again
      @errors << "original string and decrypted one don't match."
    end
  end

  def cleanup
    # Add cleanup code here
  end

end
