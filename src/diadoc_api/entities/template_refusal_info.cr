module DiadocApi
  module Entity
    class TemplateRefusalInfo
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["BoxId", "Author?", "Comment?"] %}
        diadoc_property({{ f.id.stringify }}, String)
      {% end %}

      diadoc_property("Type", TemplateRefusalType)
    end

    enum TemplateRefusalType
    UnknownRefusalType
    Refusal
    Withdrawal
    end
  end
end
