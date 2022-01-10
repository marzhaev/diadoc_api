require "uri"
require "json"
require "http"
require "./diadoc_api/**"

module DiadocApi
  VERSION = "0.1.0"

  def self.new(api_token : String, username : String, password : String)
    Client.new(
      api_token: api_token,
      username: username,
      password: password
    )
  end
end
