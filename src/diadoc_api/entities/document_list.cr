module DiadocApi
  module Entity
    class DocumentList
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("Documents", Array(Document))
      diadoc_property("TotalCount", Int32)
      diadoc_property("HasMoreResults?", Bool)
    end
  end
end
