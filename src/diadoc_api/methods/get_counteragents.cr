module DiadocApi
  class GetCounteragents < MethodsWrapper
    def self.fetch(client : Client, organization : Entity::Organization, index_key : Int32?) : Entity::CounteragentList
      url = String.build do |io|
        io << "https://diadoc-api.kontur.ru/V2/GetCounteragents?myOrgId="
        io << organization.org_id
        if value = index_key
          io << "&afterIndexKey="
          io << value
        end
      end

      response = HTTP::Client.get(
        url: url,
        headers: HTTP::Headers{
          "Accept" => "application/json",
          "Authorization" => "DiadocAuth ddauth_api_client_id=#{client.api_token},ddauth_token=#{client.session_token}"
        }
      )

      check_response(response)

      return Entity::CounteragentList.from_json(response.body)
    end
  end
end
