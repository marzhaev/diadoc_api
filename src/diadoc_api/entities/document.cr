module DiadocApi
  module Entity
    class Document
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["IndexKey?", "MessageId", "EntityId", "CounteragentBoxId?", "FileName?", "DocumentDate?", "DocumentNumber?", "DepartmentId?", "FromDepartmentId?", "ToDepartmentId?", "CustomDocumentId?", "PacketId?", "RoamingNotificationStatusDescription?", "ResolutionRouteId?", "AttachmentVersion?", "TypeNamedId", "Function", "Title", "EditingSettingId?", "Version", "ProxyBoxId?", "ProxyDepartmentId?", "EventId?"] %}
        diadoc_property({{ f.id.stringify }}, String)
      {% end %}

      {% for f in ["IsDeleted?", "IsTest?", "IsEncryptedContent?", "IsRead?", "PacketIsLocked?"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : Bool{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}

      {% for f in ["CreationTimestampTicks", "SendTimestampTicks?", "DeliveryTimestampTicks?", "LastModificationTimestampTicks?"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : Wrappers::Ticks{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}

      {% for f in ["WorkflowId"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : Int32{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}

      {% for f in ["AmendmentRequestMetadata", "ConfirmationMetadata", "Content", "DocumentDirection", "DocflowStatus", "LockMode", "Origin?", "ProxySignatureStatus", "RecipientReceiptMetadata", "RecipientResponseStatus", "ResolutionStatus?", "RevocationStatus", "RoamingNotificationStatus", "SenderReceiptMetadata", "SenderSignatureStatus"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : {{ f.id }}{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}

      @[JSON::Field(key: "CustomData")]
      property custom_data : Array(CustomDataItem)

      @[JSON::Field(key: "ForwardDocumentEvents")]
      property forward_document_events : Array(ForwardDocumentEvent)

      @[JSON::Field(key: "Metadata")]
      property metadata : Array(MetadataItem)

      @[JSON::Field(key: "LastOuterDocflows")]
      property last_outer_docflows : Array(LastOuterDocflow)

      {% for f in ["InitialDocumentIds", "SubordinateDocumentIds"] %}
        @[JSON::Field(key: {{ f.id.stringify }})]
        property {{ f.id.stringify.underscore.id }} : Array(DocumentId)
      {% end %}

      # Undocumented fields
      {% for f in ["EntityIdGuid", "MessageIdGuid", "CreationTimestamp", "CounteragentBoxIdGuid"] %}
        @[JSON::Field(key: {{ f.id.stringify.gsub(/\?/, "") }} )]
        property {{ f.id.stringify.underscore.gsub(/\?/, "").id }} : String{{ f.id.stringify.ends_with?('?') ? "?".id : "".id }}
      {% end %}

      # Deprecated fields
      @[JSON::Field(key: "DocumentType")]
      property document_type : String

      @[JSON::Field(key: "HasCustomPrintForm")]
      @has_custom_print_form : Bool?

      @[Deprecated("Field is deprecated. Use DetectCustomPrintForms if needed")]
      def has_custom_print_form : Bool?
        @has_custom_print_form
      end

      def has_custom_print_form=(new_value : Bool?) : Bool?
        @has_custom_print_form = new_value
      end

      {% for f in ["NonformalizedDocumentMetadata", "InvoiceMetadata", "InvoiceRevisionMetadata", "InvoiceCorrectionMetadata", "InvoiceCorrectionRevisionMetadata", "TrustConnectionRequestMetadata", "Torg12Metadata", "AcceptanceCertificateMetadata", "ProformaInvoiceMetadata", "XmlTorg12Metadata", "XmlAcceptanceCertificateMetadata", "PriceListMetadata", "PriceListAgreementMetadata", "CertificateRegistryMetadata", "ReconciliationActMetadata", "ContractMetadata", "Torg13Metadata", "SupplementaryAgreementMetadata", "ServiceDetailsMetadata", "UniversalTransferDocumentMetadata", "UniversalTransferDocumentRevisionMetadata", "UniversalCorrectionDocumentMetadata", "UniversalCorrectionDocumentRevisionMetadata"] %}
        @[JSON::Field(key: {{ f.id.stringify }} )]
        @{{ f.id.stringify.underscore.id }} : DeprecatedObject?

        @[Deprecated("Field is deprecated and will be removed by Diadoc")]
        def {{ f.id.stringify.underscore.id }} : DeprecatedObject?
          @{{ f.id.stringify.underscore.id }}
        end

        def {{ f.id.stringify.underscore.id }}=(new_value : DeprecatedObject?) : DeprecatedObject?
          @{{ f.id.stringify.underscore.id }} = new_value
        end
      {% end %}

      # Convenience methods
      def get_document_number : String?
        if item = metadata.find{|m| m.key == "DocumentNumber"}
          return item.value
        else
          document_number
        end
      end

      def get_total_sum : Float64?
        if item = metadata.find{|m| m.key == "TotalSum"}
          return item.value.to_f
        end
      end
    end

    class DeprecatedObject
      include JSON::Serializable
    end

    enum RoamingNotificationStatus
    RoamingNotificationStatusNone
    RoamingNotificationStatusSuccess
    RoamingNotificationStatusError
    UnknownRoamingNotificationStatus
    end
  end
end
