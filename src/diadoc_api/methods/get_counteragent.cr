module DiadocApi
  class GetCounteragent < MethodsWrapper
    def self.fetch(client : Client, organization : Organization, counteragent_org_id : String) : Entity::Counteragent
      url = String.build do |io|
        io << "https://diadoc-api.kontur.ru/V2/GetCounteragent?myOrgId="
        io << organization.org_id
        if value = counteragent_org_id
          io << "&counteragentOrgId="
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

      return Entity::Counteragent.from_json(response.body)
    end
  end
end
