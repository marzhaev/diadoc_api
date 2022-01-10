module DiadocApi
  class GetDocument < MethodsWrapper
    def self.fetch(client : Client, box : Entity::Box, messageId : String, entityId : String)
      url = String.build do |io|
        io << "https://diadoc-api.kontur.ru/V3/GetDocument?boxId="
        io << box.box_id
        io << "&messageId="
        io << messageId
        io << "&entityId="
        io << entityId
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

      return Entity::Document.from_json(response.body)
    end

    class Response
      include JSON::Serializable

      @[JSON::Field(key: "TotalCount")]
      property total_count : Int32

      @[JSON::Field(key: "Counteragents")]
      property counteragents : Array(Entity::Counteragent)
    end
  end
end
