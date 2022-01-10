module DiadocApi
  module Entity
    class DocflowStatusModel # Referred to as DocflowStatusModelV3 in API documentation.
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["Severity?", "StatusText?"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : String{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}
    end
  end
end
