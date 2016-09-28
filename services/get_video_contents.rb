require 'http'

class GetVideoContents
  def self.call(current_uid:, auth_token:, course_id:, folder_id:, folder:)
    response = HTTP.auth("Bearer #{auth_token}")
                   .post("#{ENV['API_HOST']}/accounts/#{current_uid}/#{course_id}/folders/#{folder_id}/?")
    response.code == 201 ? video_contents(response.parse, folder) : []
  end

  private

  def self.video_contents(content, folder)
    f = folder[:files].map do |info|
      info[:filename]
    end
    content.map.with_index do |info, index|
      { name: info["attributes"]["name"].to_s,
        video_order: info["attributes"]["video_order"].to_i,
        video_id: info["attributes"]["video_id"].to_i,
        filename: f[index]}
    end
  end
end
