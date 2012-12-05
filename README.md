# HttpMonkey::Cookie

Rack middleware to use with [HttpMonkey](https://github.com/rogerleite/http_monkey) and support magic cookies on your requests.

TOC:

* [Installation](#installation)
* [Usage](#usage)
* [Notes](#notes)

## Installation

Add this line to your application's Gemfile:

    gem 'http_monkey-cookie'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install http_monkey-cookie

## Usage

``` ruby
require "http_monkey"
require "http_monkey/cookie"

HttpMonkey.configure do
  # Default HTTP Headers (to all requests)
  middlewares.use HttpMonkey::M::Cookie
end

response = HttpMonkey.at("http://domain.com").get
# Returns Set-Cookie: token=magic;Version=1;Comment=;Domain=.domain.com.br;Path=/;Max-Age=999999999;httpOnly

HttpMonkey.at("http://domain.com/service").get
# Uses Cookie: token=magic etc.

HttpMonkey.at("http://example.com").get
# Don't send cookies
```

## Notes

This version is experimental and can explode in any moment.

Some resources to build a new cookie project:
* [Great doc about cookies specifications](http://hc.apache.org/httpclient-3.x/cookies.html)
* [Persistent Client State HTTP Cookies (netscape spec)](http://curl.haxx.se/rfc/cookie_spec.html)
* [HTTP State Management Mechanism RFC 2109](http://pretty-rfc.herokuapp.com/RFC2109)
* [HTTP State Management Mechanism RFC 2965](http://pretty-rfc.herokuapp.com/RFC2965)
