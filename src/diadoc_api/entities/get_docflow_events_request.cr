module DiadocApi
  module Entity
    class GetDocflowEventsRequest
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("Filter", TimeBasedFilter)
      diadoc_property("AfterIndexKey?", String)
      diadoc_property("PopulateDocuments?", Bool)
      diadoc_property("InjectEntityContent?", Bool)
      diadoc_property("PopulatePreviousDocumentStates?", Bool)
      diadoc_property("MessageTypes?", Array(String))
      diadoc_property("DocumentDirections?", Array(String))
      diadoc_property("DepartmentId?", String)
      diadoc_property("TypeNamedIds?", Array(String))
      diadoc_property("CounteragentBoxId?", String)
      diadoc_property("Limit?", Int32)

      def initialize(@filter : TimeBasedFilter, @after_index_key : String? = nil, @populate_documents : Bool = false, @counteragent_box_id : String? = nil, @limit : Int32? = nil)
      end
    end
  end
end
