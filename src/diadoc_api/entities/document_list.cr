module DiadocApi
  module Entity
    class DocumentList
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "Documents")]
      property documents : Array(Document)

      @[JSON::Field(key: "TotalCount")]
      property total_count : Int32

      @[JSON::Field(key: "HasMoreResults")]
      property has_more_results : Bool?
    end
  end
end
