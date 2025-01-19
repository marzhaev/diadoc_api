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

      @[JSON::Field(key: "ValidationProtocol")]
      property validation_protocol : ValidationProtocolCheckResults?
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
    IsNotAttached
    end

    class ValidationProtocolCheckResults
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "CheckResults")]
      property check_results : Array(ValidationCheckResult)
    end

    class ValidationCheckResult
      include JSON::Serializable
      include JSON::Serializable::Strict

      @[JSON::Field(key: "Status")]
      property status : PowerOfAttorneyValidationCheckStatus?

      @[JSON::Field(key: "Name")]
      property name : String

      @[JSON::Field(key: "Error")]
      property error : PowerOfAttorneyValidationError?
    end

    enum PowerOfAttorneyValidationCheckStatus
    PowerOfAttorneyValidationCheckStatus
    Ok
    Warning
    Error
    end
  end
end
