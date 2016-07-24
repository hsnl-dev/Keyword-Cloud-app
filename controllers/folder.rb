require 'sinatra'

# Click course and show three folders(concept,subtitle,slide)
class KeywordCloudApp < Sinatra::Base
  post '/accounts/:uid/:course_id/:folder_type' do
    folders_url = "/accounts/#{@current_uid}/#{params[:course_id]}/#{params[:folder_type]}"
    if @current_uid && @current_uid.to_s == params[:uid]
      @auth_token = session[:auth_token]
      cid = params[:course_id]
      folder_type = params[:folder_type]
      folders_url = "/accounts/#{@current_uid}/#{params[:course_id]}/#{params[:folder_type]}"
      new_folder = CreateFolder.call(
        uid: @current_uid,
        auth_token: @auth_token,
        cid: cid,
        folder_url: nil,
        folder_type: folder_type)

      if new_folder
        flash[:notice] = "The folder was successfully created!"
        redirect "/accounts/#{@current_uid}/#{params[:course_id]}/#{new_folder.first['attributes']['folder_type']}"
      else
        flash[:error] = 'Failed to create folder!'
        redirect "/accounts/#{@current_uid}"
      end
    end
  end

  get '/accounts/:uid/:course_id/:folder_type' do
    if @current_uid && @current_uid.to_s == params[:uid]
      @auth_token = session[:auth_token]
      @new_folder = GetOwnedFolder.call(current_uid: @current_uid,
                                   auth_token: @auth_token,
                                   course_id: params[:course_id],
                                   folder_type: params[:folder_type])

      slim(:chapter_folder)
    else
      slim(:home)
    end
  end
end
