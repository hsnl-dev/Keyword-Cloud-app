require 'http'

class GetCourseSlide
  def self.call(current_uid:, auth_token:, course_id:, folder_id:)
    response = HTTP.auth("Bearer #{auth_token}")
                   .get("#{ENV['API_HOST']}/accounts/#{current_uid}/#{course_id}/#{folder_id}/chapter/makekeyword")
    response.code == 200 ? response.parse : []
  end
end
