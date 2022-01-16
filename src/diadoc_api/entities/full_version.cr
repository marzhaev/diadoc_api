module DiadocApi
  module Entity
    class FullVersion
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["TypeNamedId", "Function", "Version"] %}
        diadoc_property({{ f.id.stringify }}, String)
      {% end %}
    end
  end
end
