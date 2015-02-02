require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
  	class Elitmus < OmniAuth::Strategies::OAuth2
  		 # option :name, :elitmus
  		  
  		  DEFAULT_SCOPE = 'public'

  		  option :client_options, {
       		:site => 'https://www.elitmus.com',
        	:authorize_url => "/oauth/authorize",
        	:token_url => '/oauth/token'
     	  }

	      option :authorize_options, [:scope, :display, :auth_type]

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

	      def authorize_params
      		super.tap do |params|
         		%w[display scope auth_type].each do |v|
           			if request.params[v]
              			params[v.to_sym] = request.params[v]
              	  	end
          		end
          	params[:scope] ||= DEFAULT_SCOPE
          end

      end
	end
  end
end
