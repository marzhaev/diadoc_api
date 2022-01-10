module DiadocApi
  module Entity
    class AmendmentRequestMetadata
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "ReceiptStatus")]
      property receipt_status : GeneralReceiptStatus

      @[JSON::Field(key: "AmendmentFlags")]
      property amendment_flags : Int32
    end
  end
end
