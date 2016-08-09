require 'sinatra'

# Base class for KeywordCloud Web Application
class KeywordCloudApp < Sinatra::Base
  get '/intro' do
    @intro = 'intro'
    slim :intro
  end

  get '/intro/accounts/1' do
    @intro = 'intro_course'
    slim :intro_course
  end

  get '/intro/accounts/1/1' do
    @intro = 'intro_folder_type'
    slim :intro_folder_type
  end
end
