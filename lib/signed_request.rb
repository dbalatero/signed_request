require 'signed_request/version'

require 'base64'
require 'openssl'
require 'openssl/digest'

module SignedRequest
  class << self
    # Sign a request on the sending end.
    def sign(params, secret_key, options = {})
      params = params.dup

      # Flatten any sub-hashes to a single string.
      params.each do |key, value|
        params[key] = to_flat_string(value) if value.is_a?(Hash)
      end

      string_to_sign = options[:path].to_s + to_flat_string(params)

      digest  = OpenSSL::Digest::Digest.new('sha1')
      hmac = OpenSSL::HMAC.digest(digest, secret_key, string_to_sign)
      encoded = Base64.encode64(hmac).chomp
    end

    # Validate an incoming request on the receiving end.
    def validate(params, secret_key, sign_options = {})
      signature = params.delete('signature') || params.delete(:signature)

      return false unless signature

      strip_keys_from!(params, *strip_params)
      actual_signature = sign(params, secret_key, sign_options)
      actual_signature == signature
    end

  private

    def to_flat_string(hash)
      hash.sort_by { |k, | k.to_s.downcase }.map(&:join).join
    end

    def strip_keys_from!(hash, *keys)
      keys.each { |key| hash.delete(key) }
    end

    def strip_params
      @strip_params ||= %w[action controller format]
    end
  end
end
