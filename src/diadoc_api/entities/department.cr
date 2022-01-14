module DiadocApi
  module Entity
    class Department
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["DepartmentId", "ParentDepartmentId", "Name", "Abbreviation?", "Kpp?"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : String{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}

      @[JSON::Field(key: "Address")]
      property address : Address?

      @[JSON::Field(key: "IsDisabled")]
      property is_disabled : Bool?
    end
  end
end
