module DiadocApi
  module Entity
    class ParticipantResponseDocflow
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("IsFinished", Bool)
      diadoc_property("Signature?", SignatureV3)
      diadoc_property("Title?", SignedAttachmentV3)
      diadoc_property("Rejection?", SignatureRejectionDocflow)
      diadoc_property("SentAt?", Timestamp)
      diadoc_property("DeliveredAt", Timestamp)
      diadoc_property("ResponseStatus", RecipientResponseStatus)
    end
  end
end
