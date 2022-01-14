module DiadocApi
  module Entity
    class EntityObj
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["EntityId", "ParentEntityId?", "FileName", "SignerBoxId?", "NotDeliveredEventId?", "SignerDepartmentId?", "PacketId?", "AttachmentVersion?", "Version?", "ContentTypeId?", "FileName?"] %}
        diadoc_property({{ f.id.stringify }}, String)
      {% end %}

      {% for f in ["NeedRecipientSignature?", "NeedReceipt?", "IsApprovementSignature?", "IsEncryptedContent?"] %}
        diadoc_property({{ f.id.stringify }}, Bool)
      {% end %}

      {% for f in ["Labels"] %}
        diadoc_property({{ f.id.stringify }}, Array(String))
      {% end %}

      {% for f in ["RawCreationDate"] %}
        diadoc_property({{ f.id.stringify }}, Int64)
      {% end %}

      {% for f in ["EntityType", "Content", "AttachmentType", "ResolutionInfo", "ResolutionRequestInfo", "ResolutionRequestDenialInfo", "ResolutionRouteAssignmentInfo", "ResolutionRouteRemovalInfo", "CancellationInfo", "TemplateTransformationInfo", "TemplateRefusalInfo", "OuterDocflowInfo", "RevocationRequestInfo"] %}
        diadoc_property({{ f.id.stringify }}, {{ f.id }}?)
      {% end %}

      @[JSON::Field(key: "DocumentInfo")]
      property document_info : Document?
    end

    enum EntityType
      UnknownEntityType
      Attachment
      Signature
    end

    enum AttachmentType
      UnknownAttachmentType
      Nonformalized
      Invoice
      InvoiceReceipt
      InvoiceConfirmation
      InvoiceCorrectionRequest
      AttachmentComment
      DeliveryFailureNotification
      SignatureRequestRejection
      SignatureVerificationReport
      TrustConnectionRequest
      Torg12
      InvoiceRevision
      InvoiceCorrection
      InvoiceCorrectionRevision
      AcceptanceCertificate
      StructuredData
      ProformaInvoice
      XmlTorg12
      XmlAcceptanceCertificate
      XmlTorg12BuyerTitle
      XmlAcceptanceCertificateBuyerTitle
      Resolution
      ResolutionRequest
      ResolutionRequestDenial
      PriceList
      Receipt
      XmlSignatureRejection
      RevocationRequest
      PriceListAgreement
      CertificateRegistry
      ReconciliationAct
      Contract
      Torg13
      ServiceDetails
      RoamingNotification
      SupplementaryAgreement
      UniversalTransferDocument
      UniversalTransferDocumentBuyerTitle
      UniversalTransferDocumentRevision
      UniversalCorrectionDocument
      UniversalCorrectionDocumentRevision
      UniversalCorrectionDocumentBuyerTitle
      CustomData
      MoveDocument
      ResolutionRouteAssignment
      ResolutionRouteRemoval
      Title
      Cancellation
      Edition
      DeletionRestoration
      TemplateTransformation
      TemplateRefusal
      OuterDocflow
    end
  end
end
