module DiadocApi
  module Entity
    class Content
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["Size"] %}
        @[JSON::Field(key: {{ f.id.stringify }} )]
        property {{ f.id.stringify.underscore.id }} : Int32
      {% end %}

      @[JSON::Field(key: "Data")]
      property data : String?
    end
  end
end
