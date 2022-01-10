module DiadocApi
  class GetEntityContent < MethodsWrapper
    def self.fetch(client : Client, box : Entity::Box, messageId : String, entityId : String) : String
      url = String.build do |io|
        io << "https://diadoc-api.kontur.ru/V4/GetEntityContent?boxId="
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
          "Authorization" => "DiadocAuth ddauth_api_client_id=#{client.api_token},ddauth_token=#{client.session_token}"
        }
      )

      check_response(response)

      io = IO::Memory.new(response.body)
      io.set_encoding("WINDOWS-1251")
      io.gets_to_end
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
