module DiadocApi
  module Entity
    class RevocationDocflowV3
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("IsFinished", Bool)
      diadoc_property("RevocationRequest", RevocationRequestDocflow)
      diadoc_property("RevocationResponse?", RevocationResponseDocflow)
      diadoc_property("InitiatorBoxId", String)
      diadoc_property("RevocationStatus", RevocationStatus)
      diadoc_property("ResolutionEntities?", Int32)
      diadoc_property("PlainText?", ResolutionEntitiesV3)
      diadoc_property("OuterDocflowEntities", Array(OuterDocflowEntities))
    end

    class RevocationRequestDocflow
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("RevocationRequest", SignedAttachmentV3)
      diadoc_property("SentAt?", Timestamp)
      diadoc_property("DeliveredAt?", Timestamp)
      diadoc_property("RoamingNotification?", RoamingNotification)
      diadoc_property("PlainText?", String)
    end

    class RevocationResponseDocflow
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("RecipientSignature?", SignatureV3)
      diadoc_property("SignatureRejection?", SignatureRejectionDocflow)
    end
  end
end
