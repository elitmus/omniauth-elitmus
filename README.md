# Omniauth Elitmus

eLitmus OAuth2 Strategy for OmniAuth

This is official OmniAuth strategy for authenticating to eLitmus.com. To use it, you'll need to register your consumer application on elitmus.com to get pair of OAuth2 Application ID and Secret.   It supports the OAuth 2.0 server-side and client-side flows for 3rd party OAuth consumer applications 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-elitmus'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-elitmus

## Usage

OmniAuth::Strategies::Elitmus is simply a Rack middleware.

Here's a quick example, adding the middleware to a Rails app in config/initializers/omniauth.rb:


```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :elitmus, ENV['ELITMUS_KEY'], ENV['ELITMUS_SECRET'],
 	 	  :client_options => {
        	:site => ELITMUS_AUTH_CONFIG['provider_site'],
        	:authorize_path => ELITMUS_AUTH_CONFIG['provider_authorize_endpoint'],
          :token_path => ELITMUS_AUTH_CONFIG['provider_token_endpoint']
     	},
    	:authorize_params => {
    		:auth_type => "reauthenticate"
    	},
      :scope => "public"
end
```

## Configuration

### Scope

lets you set scope to provide granular access to different types of data. If not provided, scope defaults to 'public' for users. you can use any one of "write", "public" and "admin" values for scope 


```ruby
use OmniAuth::Builder do
  provider :elitmus, ENV['ELITMUS_KEY'], ENV['ELITMUS_SECRET'], :scope => "admin"
end
```

### Auth_type

Optionally specifies the requested authentication feature. Valid values are 'reauthenticate'(asks the user to re-authenticate unconditionally) or nil (re-use the same session if exists and authenticate user). If not specified then default value is nil.

```ruby
use OmniAuth::Builder do
  provider :elitmus, ENV['ELITMUS_KEY'], ENV['ELITMUS_SECRET'], 
  		:authorize_params => {
    		:auth_type => "reauthenticate"
    	}
end
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/omniauth-elitmus/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
