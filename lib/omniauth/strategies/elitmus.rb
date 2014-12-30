require 'omniauth/strategies/oauth2'

module Omniauth
  module Strategies
  	class Elitmus < OmniAuth::Strategies::OAuth2
   		include OmniAuth::Strategy
	      #option :name, :elitmuscampus
	      option :client_options => {
	      	:site => "http://127.0.0.1:3000"
	      	:authorize_path => "/oauth/authorize"
	      	:token_path => "/oauth/token"
	      }

	      option :authorize_params, [:scope, :display, :auth_type]

	      uid {  raw_info["id"]  }
	    
	      info do
	        {
	          :email => raw_info["email"],
	          :name => raw_info["name"]
	        }
	      end

	      extra do 
	      	hash = {}
	      	hash['raw_info'] = raw_info
	      end 

	      def raw_info
	        @raw_info ||= access_token.get('/api/v1/me.json').parsed
	      end
	end
  end
end