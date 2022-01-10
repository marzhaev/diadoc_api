module DiadocApi
  class GetMyOrganizations < MethodsWrapper
    def self.fetch(client : Client) : Entity::OrganizationList
      response = HTTP::Client.get(
        url: "https://diadoc-api.kontur.ru/GetMyOrganizations",
        headers: HTTP::Headers{
          "Accept" => "application/json",
          "Authorization" => "DiadocAuth ddauth_api_client_id=#{client.api_token},ddauth_token=#{client.session_token}"
        }
      )

      check_response(response)

      Entity::OrganizationList.from_json(response.body)
    end
  end
end
