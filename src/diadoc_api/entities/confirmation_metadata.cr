module DiadocApi
  module Entity
    class ConfirmationMetadata
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "ReceiptStatus" )]
      property receipt_status : GeneralReceiptStatus

      @[JSON::Field(key: "DateTimeTicks" )]
      property date_time_ticks : Int64

    end
  end
end
