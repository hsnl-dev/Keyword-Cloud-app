require 'sinatra'
require 'json'

# Click course and show three folders(concept,subtitle,slide)
class KeywordCloudApp < Sinatra::Base
  get '/keyword/:uid/:course_id/chapter' do
    if @current_uid && @current_uid.to_s == params[:uid]
      @course_id = params[:course_id]
      @folder = GetOwnedFolder.call(current_uid: @current_uid,
                                    auth_token: session[:auth_token],
                                    course_id: @course_id,
                                    folder_type: "subtitles")
      @keyword = GetCourseContents.call(current_uid: @current_uid,
                                       auth_token: session[:auth_token],
                                       course_id: params[:course_id])
      @ordered_folder = @folder.sort_by { |chapter| chapter[:chapter_order] }
      slim(:show_keywords)
    else
      slim(:home)
    end
  end

  get '/keyword/:uid/:course_id/chapter/:chapter_id/makekeyword' do
    if @current_uid && @current_uid.to_s == params[:uid]
      @auth_token = session[:auth_token]
      @course_id = params[:course_id]
      @chapter_id = params[:chapter_id]
      @folder = GetOwnedFolder.call(current_uid: @current_uid,
                                    auth_token: session[:auth_token],
                                    course_id: @course_id,
                                    folder_type: "subtitles")
      @keyword = MakeKeyword.call(current_uid: @current_uid,
                                  auth_token: @auth_token,
                                  course_id: @course_id,
                                  chapter_id: @chapter_id)
      @ordered_folder = @folder.sort_by{ |chapter| chapter[:chapter_order] }
      slim(:show_keywords)
    else
      slim(:home)
    end
  end

  get '/keyword/:uid/:course_id/chapter/:chapter_id/showkeyword' do
    if @current_uid && @current_uid.to_s == params[:uid]
      @auth_token = session[:auth_token]
      @cid = params[:course_id]
      @chapter_id = params[:chapter_id]
      @folder = GetOwnedFolder.call(current_uid: @current_uid,
                                    auth_token: session[:auth_token],
                                    course_id: @cid,
                                    folder_type: "subtitles")
      @keyword = ShowKeyword.call(current_uid: @current_uid,
                                    auth_token: @auth_token,
                                    course_id: @cid,
                                    chapter_id: @chapter_id)
      @ordered_folder = @folder.sort_by{ |chapter| chapter[:chapter_order] }
      slim(:show_keywords)
    else
      slim(:home)
    end
  end
  post '/keyword/:uid/:course_id/chapter/:chapter_id/postkeyword/' do
    if @current_uid && @current_uid.to_s == params[:uid]
      @auth_token = session[:auth_token]
      @cid = params[:course_id]
      # print("~~~~~~~~~~~~~~\n\n\n")
      # print(JSON.parse(request.body.read))

      # begin
      # rescue => e
      #   flash[:error] = 'Something went wrong -- we will look into it!'
      #   logger.error "NEW FILE FAIL: #{e}"
      #   redirect folder_url
      # end
    end
  end
end
