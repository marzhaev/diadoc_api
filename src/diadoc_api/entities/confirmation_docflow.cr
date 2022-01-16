module DiadocApi
  module Entity
    class ConfirmationDocflow
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("IsFinished", Bool)
      diadoc_property("ReceiptAttachment?", SignedAttachmentV3)
      diadoc_property("SentAt?", Timestamp)
      diadoc_property("DeliveredAt?", Timestamp)
      diadoc_property("Confirmation?", ConfirmationDocflow)
      diadoc_property("Status", GeneralReceiptStatus)
    end
  end
end
