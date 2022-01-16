module DiadocApi
  module Entity
    class SignatureRejectionDocflow
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("SignatureRejection", SignedAttachmentV3)
      diadoc_property("IsFormal", Bool)
      diadoc_property("DeliveredAt?", Timestamp)
      diadoc_property("PlainText?", String)
    end
  end
end
