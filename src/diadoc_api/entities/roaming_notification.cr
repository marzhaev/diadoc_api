module DiadocApi
  module Entity
    class RoamingNotification
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("Notification", EntityObj)
      diadoc_property("Success", Bool)
    end
  end
end
