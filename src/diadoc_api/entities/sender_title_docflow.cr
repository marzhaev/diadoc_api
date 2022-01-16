module DiadocApi
  module Entity
    class SenderTitleDocflow
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("IsFinished", Bool)
      diadoc_property("Attachment", SignedAttachmentV3)
      diadoc_property("SentAt?", Timestamp)
      diadoc_property("DeliveredAt?", Timestamp)
      diadoc_property("RoamingNotification?", RoamingNotification)
      diadoc_property("SenderSignatureStatus", SenderSignatureStatus)
    end
  end
end
