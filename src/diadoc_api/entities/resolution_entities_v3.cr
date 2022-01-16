module DiadocApi
  module Entity
    class ResolutionEntitiesV3
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("Requests", Array(ResolutionRequestV3))
      diadoc_property("Resolutions", Array(ResolutionV3))
      diadoc_property("ApprovementSignatures", Array(ApprovementSignatureV3))
      diadoc_property("SignatureDenials", Array(SignatureDenialV3))
    end

    class ResolutionRequestV3
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("Entity", EntityObj)
      diadoc_property("Target", ResolutionTarget)
      diadoc_property("AuthorUserId?", String)
      diadoc_property("RequestType", ResolutionRequestType)
      diadoc_property("ResolvedWith", String)
      diadoc_property("Actions", Array(ResolutionAction))
    end

    class ResolutionV3
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("Entity", EntityObj)
      diadoc_property("ResolutionRequestId?", String)
      diadoc_property("AuthorUserId?", String)
      diadoc_property("ResolutionType", ResolutionType)
    end

    class ApprovementSignatureV3
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("Signature", SignatureV3)
      diadoc_property("ResolutionRequestId?", String)
      diadoc_property("AuthorUserId?", String)
    end

    class SignatureDenialV3
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("Entity", EntityObj)
      diadoc_property("ResolutionRequestId", String)
      diadoc_property("AuthorUserId?", String)
    end
  end
end
