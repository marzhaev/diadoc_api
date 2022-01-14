module DiadocApi
  module Entity
    class Message
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["MessageId", "FromBoxId", "FromTitle", "ToBoxId?", "ToTitle?", "CreatedFromDraftId?", "ProxyBoxId?", "ProxyTitle?"] %}
        diadoc_property( {{ f.id.stringify }}, String )
      {% end %}

      {% for f in ["TimestampTicks", "LastPatchTimestampTicks"] %}
        diadoc_property( {{ f.id.stringify }}, Int64 )
      {% end %}

      {% for f in ["IsDraft?", "DraftIsLocked?", "DraftIsRecycled?", "IsDeleted?", "IsTest?", "IsInternal?", "IsProxified?", "PacketIsLocked?", "IsReusable?"] %}
        diadoc_property( {{ f.id.stringify }}, Bool )
      {% end %}

      @[JSON::Field(key: "Entities")]
      property entities : Array(EntityObj)

      @[JSON::Field(key: "DraftIsTransformedToMessageIdList")]
      property draft_is_transformed_to_message_id_list : Array(String)

      @[JSON::Field(key: "LockMode")]
      property lock_mode : LockMode

      @[JSON::Field(key: "MessageType")]
      property message_type : MessageType

      @[JSON::Field(key: "TemplateToLetterTransformationInfo")]
      property template_to_letter_transformation_info : TemplateToLetterTransformationInfo?
    end
  end
end
