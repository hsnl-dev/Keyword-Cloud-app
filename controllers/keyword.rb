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

  #顯示文字雲，點擊後，有幾個章節就有幾個文字雲按鈕
  post '/accounts/:uid/:course_id/chapter/keyword' do
    if @current_uid && @current_uid.to_s == params[:uid]
      @course_id = params[:course_id]
      @folder = GetOwnedFolder.call(current_uid: @current_uid,
                                    auth_token: session[:auth_token],
                                    course_id: @course_id,
                                    folder_type: "subtitles")
      @course = GetCourseContents.call(current_uid: @current_uid,
                                       auth_token: session[:auth_token],
                                       course_id: params[:course_id])
      slim(:show_keywords)

    else
      slim(:home)
    end
  end

end
