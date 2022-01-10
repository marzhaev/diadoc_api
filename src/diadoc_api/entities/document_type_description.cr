module DiadocApi
  module Entity
    class DocumentTypeDescription
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["Name", "Title"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : String{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}

      {% for f in ["SupportedDocflows"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : Array(Int32{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }})
      {% end %}

      {% for f in ["RequiresFnsRegistration"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : Bool{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}

      @[JSON::Field(key: "Functions")]
      property functions : Array(DocumentFunction)
    end

    class DocumentFunction
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "Name")]
      property name : String

      @[JSON::Field(key: "Versions")]
      property versions : Array(DocumentVersion)
    end

    class DocumentVersion
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["Version"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : String{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}

      {% for f in ["SupportsContentPatching", "SupportsEncrypting", "SupportsPredefinedRecipientTitle", "SupportsAmendmentRequest", "IsActual"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : Bool{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}

      @[JSON::Field(key: "Titles")]
      property titles : Array(DocumentTitle)

      @[JSON::Field(key: "Workflows")]
      property workflows : Array(DocumentWorkflow)
    end

    class DocumentTitle
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "Index")]
      property index : Int32

      @[JSON::Field(key: "IsFormal")]
      property is_formal : Bool

      @[JSON::Field(key: "XsdUrl")]
      property xsd_url : String?

      @[JSON::Field(key: "UserDataXsdUrl")]
      property user_data_xsd_url : String?

      @[JSON::Field(key: "SignerInfo")]
      property signer_info : SignerInfo

      @[JSON::Field(key: "MetadataItems")]
      property metadata_items : Array(DocumentMetadataItem)

      @[JSON::Field(key: "EncryptedMetadataItems")]
      property encrypted_metadata_items : Array(DocumentMetadataItem)
    end

    class SignerInfo
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "SignerType")]
      property signer_type : Int32

      @[JSON::Field(key: "ExtendedDocumentTitleType")]
      property extended_document_title_type : Int32
    end

    class DocumentMetadataItem
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "Id")]
      property id : String

      @[JSON::Field(key: "Type")]
      property type_ : Int32

      @[JSON::Field(key: "IsRequired")]
      property is_required : Bool

      @[JSON::Field(key: "Source")]
      property source : Int32
    end

    class DocumentWorkflow
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "Id")]
      property id : Int32

      @[JSON::Field(key: "IsDefault")]
      property is_default : Bool
    end
  end
end
