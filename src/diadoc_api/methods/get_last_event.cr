module DiadocApi
  class GetLastEvent < MethodsWrapper
    def self.fetch(client : Client, box : Entity::Box)
      fetch(client, box.box_id)
    end

    def self.fetch(client : Client, box_id : String)
      url = String.build do |io|
        io << "https://diadoc-api.kontur.ru/GetLastEvent?boxId="
        io << box_id
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

      return Entity::BoxEvent.from_json(response.body)
    end
  end
end
