module DiadocApi
  class GetOrganizationsByInnKpp < MethodsWrapper
    def self.fetch(client : Client, inn : String, kpp : String? = nil, include_relations : Bool? = false) : Entity::OrganizationList
      url = String.build do |io|
        io << "https://diadoc-api.kontur.ru/GetOrganizationsByInnKpp?inn="
        io << inn
        if value = kpp
          io << "&kpp="
          io << value
        end
        if include_relations
          io << "&includeRelations=true"
        end
      end

      response = HTTP::Client.get(
        url: url,
        headers: HTTP::Headers{
          "Accept" => "application/json",
          "Authorization" => "DiadocAuth ddauth_api_client_id=#{client.api_token},ddauth_token=#{client.session_token}",
          "Content-Type" => "application/json; charset=utf-8"
        }
      )

      check_response(response)

      return Entity::OrganizationList.from_json(response.body)
    end
  end
end
