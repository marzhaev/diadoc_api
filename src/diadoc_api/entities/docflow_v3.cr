module DiadocApi
  module Entity
    class DocflowV3
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("SenderTitle", SenderTitleDocflow)
      diadoc_property("Confirmation?", ConfirmationDocflow)
      diadoc_property("ProxyResponse?", ParticipantResponseDocflow)
      diadoc_property("RecipientReceipt?", ReceiptDocflowV3)
      diadoc_property("RecipientResponse?", ParticipantResponseDocflow)
      diadoc_property("AmendmentRequest?", AmendmentRequestDocflow)
      diadoc_property("Revocation?", RevocationDocflowV3)
      diadoc_property("SenderReceipt?", ReceiptDocflowV3)
      diadoc_property("Resolution?", ResolutionDocflowV3)
      diadoc_property("ResolutionEntities?", ResolutionEntitiesV3)
      diadoc_property("OuterDocflows", Array(OuterDocflow))
      diadoc_property("OuterDocflowEntities", Array(OuterDocflowEntities))
      diadoc_property("DocflowStatus", DocflowStatusV3)
    end
  end
end
