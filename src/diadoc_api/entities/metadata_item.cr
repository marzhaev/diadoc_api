module DiadocApi
  module Entity
    class MetadataItem
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["Key", "Value"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : String{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}

    end
  end
end
