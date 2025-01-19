require "uri"
require "json"
require "http"
require "./diadoc_api/macros"
require "./diadoc_api/time_ext"
require "./diadoc_api/*"
require "./diadoc_api/entities/wrappers/ticks_wrapper"
require "./diadoc_api/entities/*"
require "./diadoc_api/methods/methods_wrapper"
require "./diadoc_api/methods/*"

module DiadocApi
  VERSION = "0.1.27"

  def self.new(api_token : String, username : String, password : String) : Client
    Client.new(
      api_token: api_token,
      username: username,
      password: password
    )
  end
end
