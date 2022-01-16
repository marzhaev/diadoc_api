module DiadocApi
  module Entity
    class CertificateVerificationResult
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("IsValid", Bool)
      diadoc_property("CertificateChain", Array(CertificateChainElement))
      diadoc_property("VerificationTime?", Timestamp)
    end
  end
end
