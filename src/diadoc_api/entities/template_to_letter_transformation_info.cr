module DiadocApi
  module Entity
    class TemplateToLetterTransformationInfo
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["LetterFromBoxId", "LetterToBoxId", "LetterFromDepartmentId?", "LetterToDepartmentId?", "LetterProxyBoxId?", "LetterProxyDepartmentId?"] %}
        diadoc_property({{ f.id.stringify }}, String)
      {% end %}
    end
  end
end
