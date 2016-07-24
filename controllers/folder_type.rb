require 'sinatra'

# Click course and show three folders(concept,subtitle,slide)
class KeywordCloudApp < Sinatra::Base
  get '/accounts/:uid/:course_id' do
    @cid = params[:course_id]
    slim(:folder_type)
  end
end
