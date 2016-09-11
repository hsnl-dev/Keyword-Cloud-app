require 'http'

class GetVideoContents
  def self.call(current_uid:, auth_token:, course_id:, folder_id:)
    response = HTTP.auth("Bearer #{auth_token}")
                   .post("#{ENV['API_HOST']}/accounts/#{current_uid}/#{course_id}/folders/#{folder_id}/?")
    response.code == 201 ? video_contents(response.parse) : []
  end
  private

  def self.video_contents(content)
    video_names = Array.new
    content.each do |item|
      video_names.push(item["attributes"]["name"].to_s)
    end
    video_names
  end
end
