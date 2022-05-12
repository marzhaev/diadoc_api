require "./xml_titles/upd_820"

module DiadocApi
  class GenerateTitleXml < MethodsWrapper

    def self.fetch(client : Client, box : Entity::Box) : String
      fetch(client: client, box_id: box.box_id)
    end


    def self.fetch(client : Client, box_id : String, type_named_id = "UniversalTransferDocument", function = "СЧФДОП", version = "utd820_05_01_02_hyphen", index = 0, body : String = "") : String
      url = String.build do |io|
        io << "https://diadoc-api.kontur.ru/GenerateTitleXml?boxId="
        io << box_id
        io << "&documentTypeNamedId=#{type_named_id}"
        io << "&documentFunction=#{URI.encode_path(function)}"
        io << "&documentVersion=#{version}"
        io << "&titleIndex=#{index}"
      end

      response = HTTP::Client.post(
        url: url,
        headers: HTTP::Headers{
          "Accept" => "application/json",
          "Authorization" => "DiadocAuth ddauth_api_client_id=#{client.api_token},ddauth_token=#{client.session_token}",
          "Content-Type" => "application/json; charset=utf-8"
        },
        body: body
      )

      check_response(response)

      return response.body
    end
  end
end
