module DiadocApi
  module Entity
    class CertificateChainElement
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("CertificateChainStatusFlags", Int32)
      diadoc_property("DerCertificate", String)
    end
  end
end
