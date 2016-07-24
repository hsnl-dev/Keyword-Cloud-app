require 'sinatra'

# Base class for KeywordCloud Web Application
class KeywordCloudApp < Sinatra::Base
  get '/login/?' do
    slim :login
  end

  post '/login/?' do
    credentials = LoginCredentials.call(params)

    if credentials.failure?
      flash[:error] = 'Account or Password incorrec'
      redirect '/login'
      halt
    end

    auth_account = FindAuthenticatedAccount.call(credentials)
    if auth_account
      @current_uid = auth_account['uid']
      session[:auth_token] = auth_account['auth_token']
      session[:current_uid] = SecureMessage.encrypt(@current_uid)
      flash[:notice] = "Welcome back"
      redirect '/'
    else
      flash[:error] = 'Your username or password did not match our records'
      redirect :login
    end
  end

  get '/logout/?' do
    @current_uid = nil
    session.clear
    flash[:notice] = 'You have logged out - please login again to use this site'
    redirect :login
  end

  get '/accounts/:uid' do
    if @current_uid && @current_uid.to_s == params[:uid]
      @auth_token = session[:auth_token]
      @owned = GetOwnedCourses.call(current_uid: @current_uid,
                                    auth_token: @auth_token)
      slim(:course)
    else
      slim(:login)
    end
  end
end
