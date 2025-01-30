module DiadocApi
  module Entity
    class ResolutionStatus
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["AuthorUserId", "AuthorFIO"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : String{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}

      @[JSON::Field(key: "Type")]
      property type_ : ResolutionStatusType

      @[JSON::Field(key: "Target")]
      property target : ResolutionTarget?
    end

    class ResolutionTarget
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["Department?", "DepartmentId?", "User?", "UserId?"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : String{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}
    end

    enum ResolutionStatusType
    None
    Approved
    Disapproved
    ApprovementRequested
    SignatureRequested
    SignatureDenied
    ActionsRequested
    end
  end
end
