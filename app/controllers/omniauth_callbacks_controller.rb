class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(provider)
    class_eval %Q{
      def provider
        @users = Users.find_for_oauth(env["omniauth.auth"], current_user)

        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
          set_flash_message(:notice, :success, kind: "provider".capitalize) if is_navigational_format?
        else
          session["devise.provider_data"] = env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end
    }
  end

  [:twitter].each do |provider|
    provides_callback_for provider
  end

  def after_sign_in_path_for(resource)
    if resource.email_verified?
      super resource
    else
      finish_signup_path(resource)
    end
  end
end
def start_oauth
  request_token = oauth_consumer.get_request_token(:oauth_callback => twitter_oauth_callback_url)
  flash[:request_token] = request_token
  redirect_to request_token.authorize_url
end

def oauth_callback
  request_token = flash[:request_token]
  if request_token
    @token = request_token.get_access_token oauth_verifier: params[:oauth_verifier]
  else
    redirect_to twitter_oauth_url
  end
end

private

def oauth_consumer
  config = Rails.application.config.twitter
  options = {
    :site => "https://api.twitter.com",
    :scheme => :header
  }

  OAuth::Consumer.new(config[:zECmmWXWr0GcWsep3CvsNXY1y], config[:6P10DIHDdtiuZJgi0vtSnJYDXSgKiJKjUVtaIdXOt1RLQI7MFa], options)

end

end
