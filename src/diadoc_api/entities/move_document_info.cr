module DiadocApi
  module Entity
    class MoveDocumentInfo
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("MovedFromDepartment", String)
      diadoc_property("MovedToDepartment", String)
    end
  end
end
