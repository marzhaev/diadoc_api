module DiadocApi
  module Entity
    class MessageToPost
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["FromBoxId", "ToBoxId"] %}
        diadoc_property( {{ f.id.stringify }}, String )
      {% end %}

      {% for f in ["IsDraft?", "LockDraft?", "StrictDraftValidation?", "DelaySend?", "LockPacket?"] %}
        diadoc_property( {{ f.id.stringify }}, Bool )
      {% end %}

      @[JSON::Field(key: "DocumentAttachments")]
      property document_attachments : Array(DocumentAttachment) = [] of DocumentAttachment

      @[JSON::Field(key: "LockMode")]
      property lock_mode : LockMode? = nil

      def initialize(@from_box_id : String, @to_box_id : String, @is_draft : Bool?)
      end
    end
  end
end
