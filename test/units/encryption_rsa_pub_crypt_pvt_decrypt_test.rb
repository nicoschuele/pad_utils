require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "EncryptionRsaPubCryptPvtDecrypt"

class EncryptionRsaPubCryptPvtDecryptTest < Test

  def prepare
    PadUtils.copy_file("fixtures/private.pem", "results/private.pem")
    PadUtils.copy_file("fixtures/public.pem", "results/public.pem")
  end

  def run_test
    secret = "Hello"
    encrypted = PadUtils.rsa_public_encrypt(content: secret, public_key: "results/public.pem")

    if encrypted.class != String
      @errors << "Encryption didn't produce a string"
    end

    decrypted = PadUtils.rsa_private_decrypt(content: encrypted, private_key: "results/private.pem")

    if decrypted != secret
      @errors << "Message not decrpyted: #{decrpyted}"
    end
  end

  def cleanup
    PadUtils.delete_file("results/private.pem") if PadUtils.file_exist?("results/private.pem")

    PadUtils.delete_file("results/public.pem") if PadUtils.file_exist?("results/public.pem")
  end

end
