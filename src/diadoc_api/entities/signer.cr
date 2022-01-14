module DiadocApi
  module Entity
    class Signer
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["SignerCertificate?", "SignerCertificateThumbprint?"] %}
        diadoc_property({{ f.id.stringify }}, String)
      {% end %}

      diadoc_property("SignerDetails?", SignerDetails)
    end

    class SignerDetails
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["Surname", "FirstName", "Patronymic?", "JobTitle?", "Inn", "SoleProprietorRegistrationCertificate?"] %}
        diadoc_property({{ f.id.stringify }}, String)
      {% end %}
    end
  end
end
