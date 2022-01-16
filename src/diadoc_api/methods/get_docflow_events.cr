module DiadocApi
  class GetDocflowEvents < MethodsWrapper
    def self.fetch(client : Client, box : Entity::Box, request : Entity::GetDocflowEventsRequest) : Entity::CounteragentList
      fetch(client, box.box_id, request)
    end

    def self.fetch(client : Client, box_id : String, request : Entity::GetDocflowEventsRequest) : Entity::GetDocflowEventsResponse
      url = String.build do |io|
        io << "https://diadoc-api.kontur.ru/V3/GetDocflowEvents?boxId="
        io << box_id
      end

      response = HTTP::Client.post(
        url: url,
        headers: HTTP::Headers{
          "Accept" => "application/json",
          "Authorization" => "DiadocAuth ddauth_api_client_id=#{client.api_token},ddauth_token=#{client.session_token}",
          "Content-Type" => "application/json; charset=utf-8"
        },
        body: request.to_json
      )

      check_response(response)

      puts response.body

      return Entity::GetDocflowEventsResponse.from_json(response.body)
    end
  end
end
