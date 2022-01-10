require "./methods_wrapper"

module DiadocApi
  class GetContent < MethodsWrapper
    def self.fetch(client : Client, type_name_id : String? = nil, function : String? = nil, version : String? = nil, title_index : String? = nil, content_type : String? = nil)
      url = String.build do |io|
        io << "https://diadoc-api.kontur.ru/GetContent?"

        if value = type_name_id
          io << "&typeNamedId="
          io << value
        end

        if value = function
          io << "&function="
          io << value
        end

        if value = version
          io << "&version="
          io << value
        end

        if value = title_index
          io << "&titleIndex="
          io << value
        end

        if value = content_type
          io << "&contentType="
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

      io = IO::Memory.new(response.body)
      io.set_encoding("WINDOWS-1251")
      return io.gets_to_end
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
