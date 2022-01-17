require "./methods_wrapper"

module DiadocApi
  class GeneratePrintForm < MethodsWrapper

    def self.fetch(client : Client, box : Entity::Box, document : Entity::Document) : String
      fetch(client: client, box_id: box.box_id, message_id: document.message_id, document_id: document.entity_id)
    end


    def self.fetch(client : Client, box_id : String, message_id : String, document_id : String) : String
      url = String.build do |io|
        io << "https://diadoc-api.kontur.ru/GeneratePrintForm?boxId="
        io << box_id
        io << "&messageId="
        io << message_id
        io << "&documentId="
        io << document_id
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

      return response.body
    end
  end
end
