module DiadocApi
  module Entity
    class ResolutionInfo
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["Author", "InitialRequestId?"] %}
        diadoc_property({{ f.id.stringify }}, String)
      {% end %}

      {% for f in ["ResolutionType?"] %}
        diadoc_property({{ f.id.stringify }}, {{ f.id }})
      {% end %}
    end

    enum ResolutionType
    UndefinedResolutionType
    Approve
    Disapprove
    UnknownResolutionType
    end
  end
end
