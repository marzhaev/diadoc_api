module DiadocApi
  module Entity
    class BoxEvent < AbstractEntity
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["EventId", "IndexKey?"] %}
        diadoc_property({{ f.id.stringify }}, String)
      {% end %}

      @[JSON::Field(key: "Message")]
      property message : Message?

      @[JSON::Field(key: "Patch")]
      property patch : MessagePatch?
    end
  end
end
