module DiadocApi
  module Entity
    class DocumentWithDocflowV3
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("DocumentId", DocumentId)
      diadoc_property("LastEvent", LastEvent)
      diadoc_property("DocumentInfo", DocumentInfoV3)
      diadoc_property("Docflow", DocflowV3)
    end

    class LastEvent
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("EventId", String)
      diadoc_property("Timestamp", Timestamp)
    end
  end
end
