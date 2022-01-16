module DiadocApi
  module Entity
    class PacketInfo
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("LockMode", LockMode)
      diadoc_property("PacketId?", String)
      diadoc_property("AddedAt?", Timestamp)
    end
  end
end
