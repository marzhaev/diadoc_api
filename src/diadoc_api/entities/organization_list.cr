require "json"

module DiadocApi
  module Entity
    class OrganizationList
      include JSON::Serializable

      @[JSON::Field(key: "Organizations")]
      property organizations : Array(Organization)
    end

    class Organization
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["OrgIdGuid", "OrgId", "Inn", "Kpp?", "FullName", "ShortName", "Ogrn?", "FnsParticipantId", "IfnsCode?", "Sociability", "CertificateOfRegistryInfo?"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : String{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}

      {% for f in ["JoinedDiadocTreaty", "IsPilot", "IsActive", "IsTest", "IsBranch", "IsRoaming", "IsEmployee", "IsForeign", "HasCertificateToSign"] %}
        @[JSON::Field(key: {{ f.id.stringify }} )]
        property {{ f.id.stringify.underscore.id }} : Bool
      {% end %}

      {% for f in ["InvitationCount", "SearchCount"] %}
        @[JSON::Field(key: {{ f.id.stringify }} )]
        property {{ f.id.stringify.underscore.id }} : Int32
      {% end %}

      @[JSON::Field(key: "Boxes")]
      property boxes : Array(Box)

      @[JSON::Field(key: "Departments")]
      property departments : Array(String)

      @[JSON::Field(key: "Address")]
      property address : Entity::Address

      {% for f in ["FnsRegistrationDate?", "LiquidationDate?"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : DiadocApi::Date{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}
    end
  end
end
