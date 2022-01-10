module DiadocApi
  class GetDocuments < MethodsWrapper
    def self.fetch(client : Client, box : Entity::Box, index_key : String? = nil, filter_category : FilterCategory  = FilterCategory.default, from_document_date : Time? = nil, to_document_date : Time? = nil, counteragent_box : Entity::Box? = nil) : Entity::DocumentList
      url = String.build do |io|
        io << "https://diadoc-api.kontur.ru/V3/GetDocuments?boxId="
        io << box.box_id
        io << "&filterCategory="
        io << filter_category.to_request

        if (value = index_key) && value != "" && value != "0"
          io << "&afterIndexKey="
          io << value
        end

        if value = from_document_date
          io << "&fromDocumentDate="
          io << value.to_diadoc.value
        end

        if value = to_document_date
          io << "&toDocumentDate="
          io << value.to_diadoc.value
        end

        if value = counteragent_box
          io << "&counteragentBoxId="
          io << counteragent_box.box_id
        end
      end

      response = HTTP::Client.get(
        url: url,
        headers: HTTP::Headers{
          "Accept" => "application/json",
          "Authorization" => "DiadocAuth ddauth_api_client_id=#{client.api_token},ddauth_token=#{client.session_token}"
        }
      )

      check_response(response)

      Entity::DocumentList.from_json(response.body)
    end
  end
end
