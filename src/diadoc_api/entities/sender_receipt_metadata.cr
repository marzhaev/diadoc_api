module DiadocApi
  module Entity
    class SenderReceiptMetadata
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "ReceiptStatus")]
      property receipt_status : GeneralReceiptStatus
    end
  end
end
