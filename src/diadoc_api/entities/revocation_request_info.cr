module DiadocApi
  module Entity
    class RevocationRequestInfo
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["Comment?", "InitiatorBoxId"] %}
        diadoc_property({{ f.id.stringify }}, String)
      {% end %}

      diadoc_property("Signer?", Signer)
    end
  end
end
