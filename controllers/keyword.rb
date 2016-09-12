require 'sinatra'

# Click course and show three folders(concept,subtitle,slide)
class KeywordCloudApp < Sinatra::Base
  #顯示文字雲，點擊後，有幾個章節就有幾個文字雲按鈕
  post '/accounts/:uid/:course_id/chapter/keyword' do
    if @current_uid && @current_uid.to_s == params[:uid]
      @cid = params[:course_id]
      @folder = GetOwnedFolder.call(current_uid: @current_uid,
                                    auth_token: session[:auth_token],
                                    course_id: @cid,
                                    folder_type: "subtitles")
      @course = GetCourseContents.call(current_uid: @current_uid,
                                       auth_token: session[:auth_token],
                                       course_id: params[:course_id])
      @ordered_folder = @folder.sort_by { |chapter| chapter[:chapter_order] }
      print(@ordered_folder)
      slim(:show_keywords)

    else
      slim(:home)
    end
  end

  get '/accounts/:uid/:course_id/chapter/:chapter_id/makekeyword' do
    if @current_uid && @current_uid.to_s == params[:uid]
      @auth_token = session[:auth_token]
      @cid = params[:course_id]
      @chapter_id = params[:chapter_id]
      @folder = GetOwnedFolder.call(current_uid: @current_uid,
                                    auth_token: session[:auth_token],
                                    course_id: @cid,
                                    folder_type: "subtitles")
      @course = GetCourseSlide.call(current_uid: @current_uid,
                                    auth_token: @auth_token,
                                    course_id: @cid,
                                    chapter_id: @chapter_id)
      @ordered_folder = @folder.sort_by{ |chapter| chapter[:chapter_order] }
      slim(:show_keywords)
    else
      slim(:home)
    end
  end
end
