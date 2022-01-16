module DiadocApi
  module Entity
    class OuterDocflowEntities
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("DocflowNamedId", String)
      diadoc_property("DocflowFriendlyName", String)
      diadoc_property("StatusEntities", Array(StatusEntity))
    end

    class StatusEntity
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("Attachment", SignedAttachmentV3)
      diadoc_property("Status", Status)
    end

    class Status
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("NamedId", String)
      diadoc_property("FriendlyName", String)
      diadoc_property("Type", OuterStatusType)
      diadoc_property("Description?", String)
      diadoc_property("Details", Array(StatusDetail))
    end

    class StatusDetail
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("Code?", String)
      diadoc_property("Text?", String)
    end
  end
end
