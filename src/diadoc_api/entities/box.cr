module DiadocApi
  module Entity
    class Box
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["BoxId", "BoxIdGuid", "Title"] %}
        @[JSON::Field(key: {{ f.id.stringify }} )]
        property {{ f.id.stringify.underscore.id }} : String
      {% end %}

      @[JSON::Field(key: "InvoiceFormatVersion")]
      property invoice_format_version : InvoiceFormatVersion = InvoiceFormatVersion::V5_02

      @[JSON::Field(key: "EncryptedDocumentsAllowed")]
      property encrypted_documents_allowed : Bool?

      def initialize(@box_id : String, @title : String)
        @box_id_guid = @box_id
      end

      enum InvoiceFormatVersion
      V5_01
      V5_02
      end

      def self.with_box_id(box_id : String) : Entity::Box
        self.new(box_id, "No title")
      end
    end
  end
end
