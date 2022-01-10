module DiadocApi
  module Entity
    class ForwardDocumentEvent
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "ToBoxId")]
      property to_box_id : String?

      @[JSON::Field(key: "Timestamp")]
      property timestamp : Date?
    end
  end
end
