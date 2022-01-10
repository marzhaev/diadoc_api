module DiadocApi
  class Authenticate
    def self.login(username : String, password : String, api_token : String) : String
      response = HTTP::Client.post(
        url: "https://diadoc-api.kontur.ru/Authenticate?login=#{username}&password=#{password}",
        headers: HTTP::Headers{"Content-Type" => "text/plain", "Authorization" => "DiadocAuth ddauth_api_client_id=#{api_token}"}
      )

      return response.body
    end
  end
end
