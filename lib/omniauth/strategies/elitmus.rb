require 'omniauth/strategies/oauth2'
require 'uri'

module OmniAuth
	module Strategies
		class Elitmus < OmniAuth::Strategies::OAuth2
			# class NoAuthorizationCodeError < StandardError; en				
			DEFAULT_SCOPE = 'public'

			#OATUH2_PROVIDER_URL = "https://www.elitmus.com"
			option :name, :elitmus

			option :client_options, {
				:site => "https://www.elitmus.com"
			}

			option :authorize_options, [:scope, :auth_type, :google_sso, :github_sso]

			uid {  raw_info['id']  }
		
			info do
				prune!({
					'email' => raw_info['email'],
					'name' => raw_info['name']
			 	})
			end

			extra do 
				hash = {}
      			hash['raw_info'] = raw_info unless skip_info?
        		prune! hash
			end 

			def raw_info
				@raw_info ||= access_token.get('/api/v1/me').parsed
			end

			def authorize_params
				super.tap do |params|
					%w[scope auth_type google_sso github_sso].each do |v|
							if request.params[v]
								params[v.to_sym] = request.params[v]
							end
					end
					params[:scope] ||= DEFAULT_SCOPE
				end
			end	

			def callback_url
				# NOTE: intentionally NOT calling `super` here. OmniAuth's default
				# callback_url is `full_host + callback_path + query_string`, where
				# query_string is whatever happens to be on the CURRENT request. That
				# makes redirect_uri drift between the /authorize request (which may
				# carry extra params like google_sso/github_sso) and the token-exchange
				# request (which additionally has code/state on it) - and OAuth2
				# requires both to match exactly, so any drift breaks the exchange.
				options[:callback_url] || (full_host + callback_path)
			end

			def prune!(hash)
				hash.delete_if do |_, value|
					prune!(value) if value.is_a?(Hash)
					value.nil? || (value.respond_to?(:empty?) && value.empty?)
        		end
     		end
		end
	end
end
