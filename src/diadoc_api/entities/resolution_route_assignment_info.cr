module DiadocApi
  module Entity
    class ResolutionRouteAssignmentInfo
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["Author", "RouteId"] %}
        diadoc_property({{ f.id.stringify }}, String)
      {% end %}
    end

    class ResolutionRouteRemovalInfo
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["Author", "RouteId"] %}
        diadoc_property({{ f.id.stringify }}, String)
      {% end %}
    end
  end
end
