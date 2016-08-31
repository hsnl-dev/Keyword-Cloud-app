require 'sinatra'

# Click course and show three folders(concept,subtitle,slide)
class KeywordCloudApp < Sinatra::Base
  get '/accounts/:uid/:course_id/folders/slides/segment' do
    if @current_uid && @current_uid.to_s == params[:uid]
      @auth_token = session[:auth_token]
      @cid = params[:course_id]
      @course = GetCourseSlide.call(current_uid: @current_uid,
                                    auth_token: @auth_token,
                                    course_id: params[:course_id])
      slim(:folder_type)
    else
      slim(:login)
    end
  end

  get '/accounts/:uid/:course_id/folders/keyword' do
    if @current_uid && @current_uid.to_s == params[:uid]
      @auth_token = session[:auth_token]
      @cid = params[:course_id]
      @course = GetCourseSlide.call(current_uid: @current_uid,
                                    auth_token: @auth_token,
                                    course_id: params[:course_id])
      slim(:keyword)
    else
      slim(:login)
    end
  end
end
