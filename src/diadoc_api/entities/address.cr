require "json"

module DiadocApi
  module Entity
    class Address
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "AddressCode")]
      property address_code : String?

      @[JSON::Field(key: "RussianAddress")]
      property russian_address : RussianAddress?

      @[JSON::Field(key: "ForeignAddress")]
      property foreign_address : ForeignAddress?
    end

    class RussianAddress
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["Apartment?", "Territory?", "Locality?", "Street?", "ZipCode?", "City?", "Region", "Building?", "Block?"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : String{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}
    end

    class ForeignAddress
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["Country", "Address"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : String{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}
    end
  end
end
