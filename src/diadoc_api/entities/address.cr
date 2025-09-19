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

      @[JSON::Field(key: "GarAddress")]
      property gar_address : GarAddress?
    end

    class RussianAddress
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["Apartment?", "Territory?", "Locality?", "Street?", "ZipCode?", "City?", "Region", "Building?", "Block?", "OtherInformation?"] %}
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

    class GarAddress
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["FiasId", "ZipCode?", "RegionCode", "DivisionType"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : String{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}

      @[JSON::Field(key: "MunicipalDistrict")]
      property municipal_district : MunicipalDistrict?

      @[JSON::Field(key: "City")]
      property city : City?

      @[JSON::Field(key: "Street")]
      property street : Street?

      @[JSON::Field(key: "Garhouse")]
      property garhouse : Garhouse?

      @[JSON::Field(key: "Settlement")]
      property settlement : Settlement?

      @[JSON::Field(key: "RoomWithinBuilding")]
      property room_within_building : RoomWithinBuilding?
    end

    class MunicipalDistrict
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "Abbreviation")]
      property abbreviation : String?

      @[JSON::Field(key: "Name")]
      property name : String?
    end

    class Street
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "Abbreviation")]
      property abbreviation : String?

      @[JSON::Field(key: "Name")]
      property name : String?
    end

    class Garhouse
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "Abbreviation")]
      property abbreviation : String?

      @[JSON::Field(key: "Number")]
      property number : String?
    end

    class Settlement
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "Abbreviation")]
      property abbreviation : String?

      @[JSON::Field(key: "Name")]
      property name : String?
    end

    class City
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "Abbreviation")]
      property abbreviation : String?

      @[JSON::Field(key: "Name")]
      property name : String?
    end

    class RoomWithinBuilding
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "Abbreviation")]
      property abbreviation : String?

      @[JSON::Field(key: "Number")]
      property number : String?
    end
  end
end
