module DiadocApi
  module Entity
    class TemplateTransformationInfo
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["Author?"] %}
        diadoc_property({{ f.id.stringify }}, String)
      {% end %}

      diadoc_property("TransformedToLetterId", DocumentId)
    end
  end
end
