require "json"

module DiadocApi
  module Entity
    class CounteragentList
      include JSON::Serializable

      @[JSON::Field(key: "TotalCount")]
      property total_count : Int32

      @[JSON::Field(key: "Counteragents")]
      property counteragents : Array(Counteragent)
    end

    class Counteragent
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["IndexKey?", "MessageToCounteragent?", "MessageFromCounteragent?", "LastEventComment?"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : String{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}

      {% for f in ["LastEventTimestampTicks"] %}
        @[JSON::Field(key: {{ f.id.stringify }} )]
        property {{ f.id.stringify.underscore.id }} : Int64
      {% end %}

      @[JSON::Field(key: "CurrentStatus")]
      property current_status : CounteragentStatus

      @[JSON::Field(key: "LastEventTimestamp")]
      property last_event_timestamp : Time #DiadocTimestamp

      @[JSON::Field(key: "Organization")]
      property organization : Organization

      @[JSON::Field(key: "InvitationDocumentId")]
      property invitation_document_id : InvitationDocumentId?
    end

    enum CounteragentStatus
    UnknownCounteragentStatus
    IsMyCounteragent
    InvitesMe
    IsInvitedByMe
    RejectsMe
    IsRejectedByMe
    NotInCounteragentList
    end

    class InvitationDocumentId
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["MessageId", "EntityId"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : String{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}
    end
  end
end
