module DiadocApi
  module Entity
    class Content
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("Size", Int32)
      diadoc_property("Data?", String)

      # Convenience methods

      def decoded_data : String?
        if d = @data
          plain = Base64.decode_string(d)
          io = IO::Memory.new(plain)
          io.set_encoding("WINDOWS-1251")
          io.gets_to_end
        end
      end

      def decoded_xml : XML::Document?
        if xml = decoded_data
          xml = xml.gsub("<?xml version=\"1.0\" encoding=\"windows-1251\"?>\r\n","")
          return XML.parse(xml)
        end
      end
    end
  end
end
