module DiadocApi
  module Entity
    class DocumentInfoV3
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("FullVersion", FullVersion)
      diadoc_property("MessageType", MessageType)
      diadoc_property("WorkflowId", Int32)
      diadoc_property("Participants", DocumentParticipants)
      diadoc_property("DocumentDirection", DocumentDirection)
      diadoc_property("DepartmentId", String)
      diadoc_property("CustomDocumentId?", String)
      diadoc_property("Metadata", Array(MetadataItem))
      diadoc_property("CustomData", Array(CustomDataItem))
      diadoc_property("DocumentLinks", DocumentLinks)
      diadoc_property("PacketInfo", PacketInfo)
      diadoc_property("IsRead", Bool)
      diadoc_property("IsDeleted", Bool)
      diadoc_property("IsInvitation", Bool)
      diadoc_property("LetterInfo?", DocumentLetterInfo)
      diadoc_property("DraftInfo?", DocumentDraftInfo)
      diadoc_property("TemplateInfo?", DocumentTemplateInfo)
      diadoc_property("Origin?", Origin)
      diadoc_property("EditingSettingId?", String)
    end

    class DocumentLetterInfo
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("IsEncrypted", Bool)
      diadoc_property("ForwardDocumentEvents", Array(ForwardDocumentEvent))
      diadoc_property("IsTest", Bool)
    end

    class DocumentDraftInfo
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("IsRecycled", Bool)
      diadoc_property("TransformedToLetterIds", Array(String))
      diadoc_property("IsLocked", Bool)
    end

    class DocumentTemplateInfo
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("LetterParticipants", DocumentParticipants)
      diadoc_property("TransformedToLetterIds", Array(String))
      diadoc_property("TemplateTransformationInfos", Array(TemplateTransformationInfo))
      diadoc_property("TemplateRefusalInfo?", TemplateRefusalInfo)
      diadoc_property("IsReusable?", Bool)
    end

    class TemplateTransformationInfo
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("TransformationId", String)
      diadoc_property("TransformedToLetterId?", DocumentId)
      diadoc_property("AuthorUserId?", String)
    end

    class TemplateRefusalInfo
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["BoxId", "AuthorUserId", "AuthorName", "Comment"] %}
        diadoc_property({{ f.id.stringify }}, String)
      {% end %}
    end
  end
end
