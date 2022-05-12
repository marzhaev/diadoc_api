module DiadocApi
  module Entity
    class DocumentAttachment
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["Comment?", "CustomDocumentId?", "TypeNamedId", "Function?", "Version?", "EditingSettingId?"] %}
        diadoc_property( {{ f.id.stringify }}, String )
      {% end %}

      {% for f in ["NeedRecipientSignature?", "NeedReceipt?", "IsEncrypted?"] %}
        diadoc_property( {{ f.id.stringify }}, Bool )
      {% end %}

      {% for f in ["WorkflowId?"] %}
        diadoc_property( {{ f.id.stringify }}, Int32 )
      {% end %}

      {% for f in ["InitialDocumentIds"] %}
        diadoc_property( {{ f.id.stringify }}, Array(DocumentId) )
      {% end %}

      @[JSON::Field(key: "CustomData")]
      property custom_data : Array(CustomDataItem)

      @[JSON::Field(key: "Metadata")]
      property metadata : Array(MetadataItem)

      @[JSON::Field(key: "SignedContent")]
      property signed_content : SignedContent?

      def initialize(@type_named_id : String, @signed_content : SignedContent, @initial_document_ids : Array(DocumentId), @custom_data : Array(CustomDataItem), @metadata : Array(MetadataItem) )
      end
    end
  end
end
