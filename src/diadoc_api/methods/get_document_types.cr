module DiadocApi
  class GetDocumentTypes < MethodsWrapper
    def self.fetch(client : Client, box : Entity::Box)
      url = String.build do |io|
        io << "https://diadoc-api.kontur.ru/V2/GetDocumentTypes?boxId="
        io << box.box_id
        io << "&messageId="
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

      return GetDocumentTypesResponse.from_json(response.body)
    end

    class GetDocumentTypesResponse
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "DocumentTypes" )]
      property document_types : Array(Entity::DocumentTypeDescription)
    end
  end
end
