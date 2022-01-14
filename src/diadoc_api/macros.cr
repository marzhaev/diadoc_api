macro diadoc_property(value, type_)
  @[JSON::Field(key: {{ value.id.stringify.gsub(/\?/, "") }} )]
  property {{ value.id.stringify.underscore.gsub(/\?/, "").id }} : {{ type_.id }}{{ value.id.stringify.ends_with?('?') ? "?".id : "".id }}
end
