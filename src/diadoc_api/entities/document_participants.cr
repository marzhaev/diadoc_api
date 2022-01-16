module DiadocApi
  module Entity
    class DocumentParticipants
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["Sender", "Proxy?", "Recipient?"] %}
        diadoc_property({{ f.id.stringify }}, DocumentParticipant)
      {% end %}

      diadoc_property("IsInternal", Bool)
    end

    class DocumentParticipant
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("BoxId", String)
      diadoc_property("DepartmentId?", String)
    end
  end
end
