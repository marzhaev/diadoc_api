module DiadocApi
  module Entity
    class MessagePatch
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["MessageId", "DeliveredPatchId?", "PatchId", "NotDeliveredEventId?", "DeliveredEventId?"] %}
        diadoc_property({{ f.id.stringify }}, String)
      {% end %}

      {% for f in ["ForDraft?", "DraftIsRecycled?", "DraftIsLocked?", "MessageIsDeleted?", "MessageIsRestored?", "MessageIsDelivered?"] %}
        diadoc_property({{ f.id.stringify }}, Bool)
      {% end %}

      diadoc_property("TimestampTicks", Int64)

      diadoc_property("Entities", Array(EntityObj))

      diadoc_property("EntityPatches", Array(EntityPatch))

      diadoc_property("DraftIsTransformedToMessageIdList", Array(String))

      diadoc_property("MessageType", MessageType)
    end

    enum MessageType
    Unknown
    Letter
    Draft
    Template
    end

    class EntityPatch
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["EntityId", "MovedToDepartment?", "ForwardedToBoxId?"] %}
        diadoc_property({{ f.id.stringify }}, String)
      {% end %}

      {% for f in ["DocumentIsDeleted?", "DocumentIsRestored?", "ContentIsPatched?"] %}
        diadoc_property({{ f.id.stringify }}, Bool)
      {% end %}
    end
  end
end
