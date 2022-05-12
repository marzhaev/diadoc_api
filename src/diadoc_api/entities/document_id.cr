module DiadocApi
  module Entity
    class DocumentId
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["MessageId", "EntityId"] %}
        diadoc_property({{ f.id.stringify }}, String)
      {% end %}

      def initialize(@message_id : String, @entity_id : String)
      end
    end
  end
end
