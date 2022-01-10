module DiadocApi
  module Entity
    class RecipientReceiptMetadata
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "ReceiptStatus")]
      property receipt_status : GeneralReceiptStatus

      @[JSON::Field(key: "ConfirmationMetadata")]
      property confirmation_metadata : ConfirmationMetadata
    end
  end
end
