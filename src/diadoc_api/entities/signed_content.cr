module DiadocApi
  module Entity
    class SignedContent
      include JSON::Serializable
      include JSON::Serializable::Strict

      {% for f in ["Content?", "Signature?", "NameOnShelf?", "SignatureNameOnShelf?"] %}
        diadoc_property( {{ f.id.stringify }}, String )
      {% end %}

      {% for f in ["SignWithTestSignature?"] %}
        diadoc_property( {{ f.id.stringify }}, Bool )
      {% end %}

      def initialize(@content : String)
      end
    end
  end
end
