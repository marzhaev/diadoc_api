module DiadocApi
  module Entity
    class ResolutionRequestInfo
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["Author", "ResolvedWith?"] %}
        diadoc_property({{ f.id.stringify }}, String)
      {% end %}

      diadoc_property("RequestType?", ResolutionRequestType)

      diadoc_property("Target?", ResolutionTarget)

      diadoc_property("Actions", Array(ResolutionAction))
    end

    enum ResolutionRequestType
    UnknownResolutionRequestType
    ApprovementRequest
    SignatureRequest
    ApprovementSignatureRequest
    Custom
    end
  end
end
