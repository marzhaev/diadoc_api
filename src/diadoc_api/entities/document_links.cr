module DiadocApi
  module Entity
    class DocumentLinks
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("InitialIds", Array(DocumentId))
      diadoc_property("SubordinateIds", Array(DocumentId))
    end
  end
end
