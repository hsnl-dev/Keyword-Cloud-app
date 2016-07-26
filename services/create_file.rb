require 'http'
require 'base64'

class CreateFile
  def self.call(current_uid:, auth_token:, course_id:, folder_id:, filename:, document:)
    base64_encode_document = Base64.strict_encode64(document)
    response = HTTP.auth("Bearer #{auth_token}")
                   .post("#{ENV['API_HOST']}/accounts/#{current_uid}/#{course_id}/folders/#{folder_id}/files/",
                         json: {filename: filename, document: base64_encode_document})
    response.code == 201 ? response.parse : nil
  end
end
