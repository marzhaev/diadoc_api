module DiadocApi
  module Entity
    class SignatureVerificationResult
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("IsValid", Bool)
      diadoc_property("CertificateStatus?", CertificateVerificationResult)
      diadoc_property("SignatureTimestamp?", Timestamp)
    end
  end
end
