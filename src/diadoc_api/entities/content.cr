module DiadocApi
  module Entity
    class Content
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["Size"] %}
        @[JSON::Field(key: {{ f.id.stringify }} )]
        property {{ f.id.stringify.underscore.id }} : Int32
      {% end %}

      @[JSON::Field(key: "Data")]
      property data : String?

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
