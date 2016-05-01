require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "EncryptionRsaGeneratePvtKey"

class EncryptionRsaGeneratePvtKeyTest < Test

  def prepare
    @start_time = Time.now
  end

  def run_test
    key = PadUtils.generate_rsa_private_key key_size: 2048, path: "results/private.pem"
    if key.class != OpenSSL::PKey::RSA
      @errors << "Key not generated"
    end

    if !PadUtils.file_exist?("results/private.pem")
      @errors << "Key not saved on disk"
    end
  end

  def cleanup
    @end_time = Time.now
    @notes << "Key generated in #{PadUtils.interval(@start_time, @end_time)} seconds"

    PadUtils.delete_file("results/private.pem") if PadUtils.file_exist?("results/private.pem")
  end

end
