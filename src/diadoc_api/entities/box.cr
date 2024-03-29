module DiadocApi
  module Entity
    class Box
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["BoxId", "BoxIdGuid", "Title"] %}
        @[JSON::Field(key: {{ f.id.stringify }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : String{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}

      @[JSON::Field(key: "InvoiceFormatVersion")]
      property invoice_format_version : InvoiceFormatVersion = InvoiceFormatVersion::V5_02

      @[JSON::Field(key: "EncryptedDocumentsAllowed")]
      property encrypted_documents_allowed : Bool?

      @[JSON::Field(key: "Organization")]
      property organization : Organization?

      enum InvoiceFormatVersion
      V5_01
      V5_02
      end
    end
  end
end
