module DiadocApi
  module Entity
    class Attachment
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("Entity?", EntityObj)
      diadoc_property("AttachmentFilename", String)
      diadoc_property("DisplayFilename", String)
    end
  end
end
