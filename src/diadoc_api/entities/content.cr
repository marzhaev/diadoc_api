module DiadocApi
  module Entity
    class Content
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("Size", Int32)
      diadoc_property("Data?", String)

      # Convenience methods

      # Search for <Файл to avoid LibXML's run-time errors
      def decoded_data : String?
        if d = @data
          io = IO::Memory.new(Base64.decode_string(d))
          io.set_encoding("WINDOWS-1251")
          str = io.gets_to_end
          if index = str.byte_index("<Файл")
            str.delete_at(0, index)
          else
            str
          end
        end
      end

      def decoded_xml : XML::Node?
        if xml = decoded_data
          XML.parse(xml)
        end
      end
    end
  end
end
