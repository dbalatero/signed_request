require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe SignedRequest do
  before(:each) do
    @test_key = 'mykey'
  end

  describe "sign" do
    it "should sign the request and return the correct signed key as base64" do
      params = {
        "tokenID" => "N1CHGCG13NNB4JMVJN1Q1JXIKBQDO4DQ595NRSCTILAU47P7GA7JVQMMJNXRUJFM", 
        "callerReference" => "44441234567fdsa44",
        "expiry" => "10/2014",
        "status" => "SC"
      }

      result = SignedRequest.sign(params, @test_key)
      result.should == "uoOmSftU4gnUMK6Q1ylyGnr5hEw="
    end

    it "should handle params with hashes as values deterministically" do
      params = {
        :user => {
          :username => 'dbalatero',
          :password => 'password',
          :password_confirmation => 'password',
          :token => 'z883481299kxkldksjkfdsalfdasfdas'
        }
      }

      sig = SignedRequest.sign(params, @test_key)
      20.times do
        SignedRequest.sign(params.dup, @test_key).should == sig
      end
    end
  end

  describe "validate" do
    it "should decode params with hashes as values correctly" do
      params = {
        :user => {
          :username => 'dbalatero',
          :password => 'password',
          :password_confirmation => 'password',
          :token => 'z883481299kxkldksjkfdsalfdasfdas'
        },
        :test => 'ok'
      }

      sig = SignedRequest.sign(params, @test_key)
      params['signature'] = sig

      result = SignedRequest.validate(params, @test_key)
      result.should be_true
    end

    it "should return true given a correct request" do
      good_params = {
        "tokenID" => "N1CHGCG13NNB4JMVJN1Q1JXIKBQDO4DQ595NRSCTILAU47P7GA7JVQMMJNXRUJFM", 
        "callerReference" => "44441234567fdsa44",
        "action" => "amazon_return",
        "signature" => "uoOmSftU4gnUMK6Q1ylyGnr5hEw=",
        "controller" => "checkout",
        "expiry" => "10/2014",
        "status" => "SC"
      }

      SignedRequest.validate(good_params, @test_key).should be_true
    end

    it "should return false if there is no signature given" do
      good_params_without_signature = {
        "tokenID" => "N1CHGCG13NNB4JMVJN1Q1JXIKBQDO4DQ595NRSCTILAU47P7GA7JVQMMJNXRUJFM", 
        "callerReference" => "44441234567fdsa44",
        "action" => "amazon_return",
        "controller" => "checkout",
        "expiry" => "10/2014",
        "status" => "SC"
      }

      SignedRequest.validate(good_params_without_signature, @test_key).should be_false
    end

    it "should return false if there is a bad signature given" do
      result = SignedRequest.validate({'signature' => 'bad', 'param1' => 'ok'}, @test_key)
      result.should be_false
    end
  end
end
