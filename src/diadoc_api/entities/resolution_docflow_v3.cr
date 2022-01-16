module DiadocApi
  module Entity
    class ResolutionDocflowV3
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("IsFinished", Bool)
      diadoc_property("ParentEntityId", String)
      diadoc_property("ResolutionStatus", ResolutionStatus)
      diadoc_property("ResolutionEntityId?", String)
    end
  end
end
