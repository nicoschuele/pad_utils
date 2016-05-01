require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "EncryptionRsaPubFromPvt"

class EncryptionRsaPubFromPvtTest < Test

  def prepare
    PadUtils.copy_file("fixtures/private.pem", "results/private.pem")
  end

  def run_test
    key = PadUtils.generate_rsa_public_key(private_key: "results/private.pem", path: "results/public.pem")

    if key.class != OpenSSL::PKey::RSA
      @errors << "Public key not generated"
    end

    if !PadUtils.file_exist?("results/public.pem")
      @errors << "Public key not saved on disk"
    end
  end

  def cleanup
    PadUtils.delete_file("results/private.pem") if PadUtils.file_exist?("results/private.pem")

    PadUtils.delete_file("results/public.pem") if PadUtils.file_exist?("results/public.pem")
  end

end
