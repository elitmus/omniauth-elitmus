# ------------------------------------------------------------------
# This is an implementation of elitmus Oauth strategy
# couyright (c) elitmus.com
# ------------------------------------------------------------------

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

			option :authorize_options, [:scope, :auth_type]

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

					%w[scope auth_type].each do |v|
						  rparamsv = request.params[v]
							if rparamsv
								params[v.to_sym] = rparamsv
							end
					end
					params[:scope] ||= DEFAULT_SCOPE
				end
			end

			def callback_url
				options[:callback_url] || super
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
