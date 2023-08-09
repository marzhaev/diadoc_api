module DiadocApi
  module Entity
    class PowerOfAttorneyValidationStatus
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "Severity")]
      property severity : Severity?

      @[JSON::Field(key: "StatusNamedId")]
      property status_named_id : PowerOfAttorneyValidationStatusNamedId?

      @[JSON::Field(key: "StatusText")]
      property status_text : String?

      @[JSON::Field(key: "Errors")]
      property errors : Array(PowerOfAttorneyValidationError)
    end

    class PowerOfAttorneyValidationError
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "Code")]
      property code : String

      @[JSON::Field(key: "Text")]
      property text : String
    end

    enum Severity
    UnknownSeverity
    Info
    Success
    Warning
    Error
    end

    enum PowerOfAttorneyValidationStatusNamedId
    UnknownStatus
    CanNotBeValidated
    IsValid
    IsNotValid
    ValidationError
    end
  end
end
