module DiadocApi
  module Entity
    class OuterDocflowInfo
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["DocflowNamedId", "DocflowFriendlyName"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : String{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}

      @[JSON::Field(key: "Status")]
      property status : Status
    end

    class Status
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["NamedId", "FriendlyName", "Description?"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : String{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}

      @[JSON::Field(key: "Type")]
      property type : StatusType

      @[JSON::Field(key: "Details")]
      property details : Array(StatusDetail)
    end

    class StatusDetail
      include JSON::Serializable
      include JSON::Serializable::Strict
      
      {% for f in ["Code", "Text"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : String{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}
    end

    # OuterStatusType or StatusType?
    enum StatusType
    UnknownType
    Normal
    Success
    Warning
    Error
    end
  end
end
