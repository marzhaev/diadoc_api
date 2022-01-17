module DiadocApi
  class GetDocuments < MethodsWrapper
    def self.fetch(client : Client, box : Entity::Box, index_key : String? = nil, filter_category : FilterCategory  = FilterCategory.default, from_document_date : Time? = nil, to_document_date : Time? = nil, counteragent_box : Entity::Box? = nil) : Entity::DocumentList
      fetch(client: client, box_id: box.box_id, index_key: index_key, filter_category: filter_category, from_document_date: from_document_date, to_document_date: to_document_date, counteragent_box_id: counteragent_box.try{|v| v.box_id})
    end

    def self.fetch(client : Client, box_id : String, index_key : String? = nil, filter_category : FilterCategory  = FilterCategory.default, from_document_date : Time? = nil, to_document_date : Time? = nil, counteragent_box_id : String? = nil) : Entity::DocumentList
      url = String.build do |io|
        io << "https://diadoc-api.kontur.ru/V3/GetDocuments?boxId="
        io << box_id
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

        if value = counteragent_box_id
          io << "&counteragentBoxId="
          io << value
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
