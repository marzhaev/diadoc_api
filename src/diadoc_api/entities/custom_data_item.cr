module DiadocApi
  module Entity
    class CustomDataItem
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "Key")]
      property key : String

      @[JSON::Field(key: "Value")]
      property value : String?
    end
  end
end
