module DiadocApi
  module Entity
    class SignatureV3
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("Cms", EntityObj)
      diadoc_property("CadesT", EntityObj)
      diadoc_property("SignerBoxId", String)
      diadoc_property("SignerDepartmentId", String)
      diadoc_property("IsValid", Bool)
      diadoc_property("VerificationResult?", SignatureVerificationResult)
      diadoc_property("DeliveredAt?", Timestamp)
    end
  end
end
