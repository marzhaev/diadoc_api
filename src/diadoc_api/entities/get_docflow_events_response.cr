module DiadocApi
  module Entity
    class GetDocflowEventsResponse
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("TotalCount?", Int32)
      diadoc_property("Events", Array(DocflowEventV3))
      diadoc_property("TotalCountType", TotalCountType)
    end
  end
end
