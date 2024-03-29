module DiadocApi
  module Entity
    class ForwardDocumentEvent
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("ToBoxId?", String)
      diadoc_property("Timestamp?", Date)
    end
  end
end
