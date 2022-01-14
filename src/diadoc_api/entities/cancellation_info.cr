module DiadocApi
  module Entity
    class CancellationInfo
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["Author"] %}
        diadoc_property({{ f.id.stringify }}, String)
      {% end %}
    end
  end
end
