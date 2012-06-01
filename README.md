# signed_request

A simple gem for signing/verifying an HTTP request that has gone over the wire.

The sender and receiver must share the same secret key between them.

This gem should be used in conjunction with SSL certificates to defend against 
replay attacks.

Any key can be used to sign the request -- choosing a secure key is the choice of the
user of this library.

## Signing a request

```ruby
require 'signed_request'

def send_over_the_wire
  key = 'mykey'  # insecure, use something else :)
  params = { 'param1' => 'foo',
             'param2' => 'bar' }
  signature = SignedRequest.sign(params, key)

  params['signature'] = signature

  # post it to the receiver.
  req = Net::HTTP::Get.new('/secret/url')
  req.form_data = params
  http = Net::HTTP.new('mydomain.com', 443)
  http.use_ssl = true
  response = http.start do |session|
    session.request(req)
  end

  # do something w/ response
end
```

## Verifying a signed request

```ruby
require 'signed_request'

class SecretController < ApplicationController
  def verify_request
    key = 'mykey'

    if SignedRequest.validate(params, key)
      # we are good
    else
      abort "get the hell out of here!"
    end
  end
end
```

## Copyright

Copyright (c) 2009-2012, David Balatero, Rob Hanlon.
