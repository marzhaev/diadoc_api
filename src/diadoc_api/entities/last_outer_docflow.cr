module DiadocApi
  module Entity
    class LastOuterDocflow
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "ParentEntityId")]
      property parent_entity_id : String

      @[JSON::Field(key: "OuterDocflow")]
      property outer_docflow : OuterDocflowInfo
    end
  end
end
