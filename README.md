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

Here's a quick example, adding the middleware to a Rails app in config/initializers/omniauth.rb.
You need to configure your consumer app_id, secret to 'ELITMUS_KEY', 'ELITMUS_SECRET' environement variables respectively. To get app_id and secret you need to register your application at 'www.elitmus.com/oauth/applications' with valid callback url directing to your app.


```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :elitmus, ENV['ELITMUS_KEY'], ENV['ELITMUS_SECRET']
end
```

## Configuration

You can configure several options, which you pass in to the `provider` method via a `Hash`:

Option name | Default | Explanation
--- | --- | ---
`scope` | `public` | lets you set scope to provide granular access to different types of data. If not provided, scope defaults to 'public' for users. you can use any one of "write", "public" and "admin" values for scope. please refer 'Examples' section below. See the Facebook docs for a full list of available permissions: https://developers.facebook.com/docs/reference/login/
`auth_type` | | Optionally specifies the requested authentication feature. Valid value is 'reauthenticate' (it asks the user to re-authenticate unconditionally). If not specified, default value is nil. (it reuses the existing session of last authenticated user if any). refer 'Examples' section below.
`display` | `page` | The display context to show the authentication page. Options are: `page`, `popup` and `touch`.

## Examples 

### scope

```ruby
use OmniAuth::Builder do
  provider :elitmus, ENV['ELITMUS_KEY'], ENV['ELITMUS_SECRET'], { :scope => "admin" }
end
```
If not specified, default scope is 'public'

### auth_type

```ruby
use OmniAuth::Builder do
  provider :elitmus, ENV['ELITMUS_KEY'], ENV['ELITMUS_SECRET'], 
  		{ :scope => "admin", :authorize_params => { :auth_type => "reauthenticate" }}
end
```
If not specified, default is nil.

### display

```ruby
use OmniAuth::Builder do
  provider :elitmus, ENV['ELITMUS_KEY'], ENV['ELITMUS_SECRET'], 
      { :scope => "admin", :authorize_params => { :auth_type => "reauthenticate" }}
end
```
If not specified, default is 'page'.

## Auth Hash

Here's an example *Auth Hash* available in `request.env['omniauth.auth']`:

```ruby
{
  :provider => 'elitmus',
  :uid => '1234567',
  :info => {
    :email => 'joe@bloggs.com',
    :name => 'Joe Bloggs'
  },
  :credentials => {
    :token => 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
    :expires_at => 1321747205, # when the access token expires (it always will)
    :expires => true # this will always be true
  },
  :extra => {
    :raw_info => {
      :id => '1234567',
      :channel => 'Through a friend',
      :email => 'joe@bloggs.com',
      :name => 'Joe Bloggs'
      :email_lower => 'joe@bloggs.com',
      :first_login => 'Y',
      :registered_on => '2012-01-17T00:37:29+05:30',
      :source_campus => '0',
      :status => 'active'
    }
  }
}
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/omniauth-elitmus/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
