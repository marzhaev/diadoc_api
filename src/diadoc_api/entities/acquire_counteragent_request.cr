module DiadocApi
  module Entity
    class AcquireCounteragentRequest
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("OrgId?", String)
      diadoc_property("Inn?", String)
      diadoc_property("MessageToCounteragent?", String)

      def initialize(@org_id : String? = nil, @inn : String? = nil, @message_to_counteragent : String? = nil)
      end
    end
  end
end
