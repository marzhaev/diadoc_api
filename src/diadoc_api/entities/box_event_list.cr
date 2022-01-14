module DiadocApi
  module Entity
    class BoxEventList
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["TotalCount?"] %}
        diadoc_property({{ f.id.stringify }}, Int32)
      {% end %}

      @[JSON::Field(key: "Events")]
      property events : Array(BoxEvent)

      @[JSON::Field(key: "TotalCountType")]
      property total_count_type : TotalCountType
    end

    enum TotalCountType
      Equal
      GreaterThanOrEqual
    end
  end
end
