require 'base64'
require 'openssl'
require 'openssl/digest'

module SignedRequest
  STRIP_PARAMS = ['action', 'controller', 'format'] 

  # Sign a request on the sending end.
  def self.sign(params, secret_key)
    query   = params.sort_by { |k,v| k.to_s.downcase }
    digest  = OpenSSL::Digest::Digest.new('sha1')
    hmac    = OpenSSL::HMAC.digest(digest, secret_key, query.to_s)
    encoded = Base64.encode64(hmac).chomp
  end

  # Validate an incoming request on the receiving end.
  def self.validate(params, secret_key)
    signature = params.delete('signature')
    return false if !signature

    strip_keys_from!(params, *STRIP_PARAMS)
    actual_signature = sign(params, secret_key)
    actual_signature == signature
  end

  private
  def self.strip_keys_from!(hash, *keys)
    keys.each do |key|
      hash.delete(key)
    end
  end
end
