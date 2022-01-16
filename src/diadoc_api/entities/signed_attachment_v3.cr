module DiadocApi
  module Entity
    class SignedAttachmentV3
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("Attachment", Attachment)
      diadoc_property("Attachment?", SignatureV3)
      diadoc_property("Comment?", EntityObj)
      diadoc_property("ContentTypeId", String)
    end
  end
end
