module DiadocApi
  class AcquireCounteragent < MethodsWrapper
    def self.fetch(client : Client, my_org_id : String, request : Entity::AcquireCounteragentRequest) : String
      url = String.build do |io|
        io << "https://diadoc-api.kontur.ru/V2/AcquireCounteragent?myOrgId="
        io << my_org_id
      end

      response = HTTP::Client.post(
        url: url,
        headers: HTTP::Headers{
          "Accept" => "application/json",
          "Authorization" => "DiadocAuth ddauth_api_client_id=#{client.api_token},ddauth_token=#{client.session_token}",
          "Content-Type" => "application/json; charset=utf-8"
        },
        body: request.to_json
      )

      check_response(response)

      response.body
    end
  end
end
