module DiadocApi
  module Entity
    class Origin
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["MessageId"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : String{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}

      @[JSON::Field(key: "MessageType")]
      property message_type : MessageType

      enum MessageType
      Unknown
      Letter
      Draft
      Template
      end
    end
  end
end
