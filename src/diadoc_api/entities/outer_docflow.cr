module DiadocApi
  module Entity
    class OuterDocflow
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("DocflowNamedId", String)
      diadoc_property("ParentEntityId", String)
      diadoc_property("OuterDocflowEntityId", String)
    end
  end
end
