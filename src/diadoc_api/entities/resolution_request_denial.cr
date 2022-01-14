module DiadocApi
  module Entity
    class ResolutionRequestDenialInfo
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["Author", "InitialRequestId?"] %}
        diadoc_property({{ f.id.stringify }}, String)
      {% end %}
    end

    class ResolutionRequestDenialAttachment
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["InitialResolutionRequestId", "Comment?"] %}
        diadoc_property({{ f.id.stringify }}, String)
      {% end %}

      {% for f in ["Labels"] %}
        diadoc_property({{ f.id.stringify }}, Array(String))
      {% end %}
    end

    class ResolutionRequestDenialCancellationAttachment
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["InitialResolutionRequestDenialId"] %}
        diadoc_property({{ f.id.stringify }}, String)
      {% end %}
    end
  end
end
