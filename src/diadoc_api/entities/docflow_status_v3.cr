module DiadocApi
  module Entity
    class DocflowStatusV3
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["PrimaryStatus", "SecondaryStatus?"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : DocflowStatusModel{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}
    end
  end
end
