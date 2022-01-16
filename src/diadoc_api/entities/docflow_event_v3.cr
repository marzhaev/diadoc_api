module DiadocApi
  module Entity
    class DocflowEventV3
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("EventId?", String)
      diadoc_property("Timestamp?", Timestamp)
      diadoc_property("DocumentId?", DocumentId)
      diadoc_property("IndexKey?", String)
      diadoc_property("Document?", DocumentWithDocflowV3)
      diadoc_property("PreviousEventId?", String)
      diadoc_property("PreviousDocumentState?", DocumentWithDocflowV3)
    end
  end
end
