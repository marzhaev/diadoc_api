require "./methods_wrapper"

module DiadocApi
  class PostMessage < MethodsWrapper

    def self.fetch(client : Client, message : Entity::MessageToPost) : Entity::Message
      fetch(client: client, message: message)
    end


    def self.fetch(client : Client, message : Entity::MessageToPost) : Entity::Message
      url = String.build do |io|
        io << "https://diadoc-api.kontur.ru/V3/PostMessage"
      end

      response = HTTP::Client.post(
        url: url,
        headers: HTTP::Headers{
          "Accept" => "application/json",
          "Authorization" => "DiadocAuth ddauth_api_client_id=#{client.api_token},ddauth_token=#{client.session_token}",
          "Content-Type" => "application/json; charset=utf-8"
        },
        body: message.to_json
      )

      check_response(response)

      return Entity::Message.from_json(response.body)
    end
  end
end
