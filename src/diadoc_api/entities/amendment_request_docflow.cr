module DiadocApi
  module Entity
    class AmendmentRequestDocflow
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("IsFinished", Bool)
      diadoc_property("AmendmentRequest?", SignedAttachmentV3)
      diadoc_property("SentAt?", Timestamp)
      diadoc_property("DeliveredAt?", Timestamp)
      diadoc_property("Receipt?", ReceiptDocflowV3)
      diadoc_property("AmendmentFlags", Int32)
      diadoc_property("PlainText?", String)
      diadoc_property("ConfirmationDocflow?", ConfirmationDocflow)
    end
  end
end
