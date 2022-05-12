module DiadocApi
  class Client
    property api_token : String
    property username : String
    property password : String
    property session_token : String?

    HOST = "https://diadoc-api.kontur.ru/"

    def initialize(@api_token : String, @username : String, @password : String)
    end

    # Methods for Diadoc API

    def authenticate
      return if @session_token
      authenticate!
    end

    def authenticate!
      @session_token = Authenticate.login(username: username, password: password, api_token: api_token)
    end

    def acquire_counteragent(org_id : String, request : Entity::AcquireCounteragentRequest)
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      AcquireCounteragent.fetch(self, org_id, request)
    end

    def generate_print_form(box : Entity::Box, document : Entity::Document) : String
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GeneratePrintForm.fetch(self, box, document)
    end

    def generate_print_form(box_id : String, message_id : String, document_id : String)
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GeneratePrintForm.fetch(self, box_id, message_id, document_id)
    end

    def generate_title_xml(box_id : String, body : String) : String
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GenerateTitleXml.fetch(self, box_id, body: body)
    end

    def get_box(box : Entity::Box) : Entity::Box
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetBox.fetch(self, box: box)
    end

    def get_box(box_id : String) : Entity::Box
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetBox.fetch(self, box_id: box_id)
    end

    def get_content(type_name_id : String? = nil, function : String? = nil, version : String? = nil, title_index : String? = nil, content_type : String? = nil)
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetContent.fetch(self, type_name_id, function, version, title_index, content_type)
    end

    def get_counteragent(organization : Entity::Organization, counteragent_org_id : String) : Entity::Counteragent
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetCounteragent.fetch(self, organization, counteragent_org_id)
    end

    def get_counteragents(organization : Entity::Organization, index_key : Int32? = nil) : Entity::CounteragentList
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetCounteragents.fetch(self, organization, index_key)
    end

    def get_docflow_events(box : Entity::Box, request : Entity::GetDocflowEventsRequest)
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetDocflowEvents.fetch(self, box, request)
    end

    def get_docflow_events(box_id : String, request : Entity::GetDocflowEventsRequest)
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetDocflowEvents.fetch(self, box_id, request)
    end

    def get_document(box : Entity::Box, message_id : String, entity_id : String)
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetDocument.fetch(self, box, message_id, entity_id)
    end

    def get_document_types(box : Entity::Box)
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetDocumentTypes.fetch(self, box)
    end

    def get_documents(box_id : String, index_key : String? = nil, filter_category : FilterCategory  = FilterCategory.default, from_document_date : Time? = nil, to_document_date : Time? = nil, counteragent_box_id : String? = nil) : Entity::DocumentList
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetDocuments.fetch(client: self, box_id: box_id, index_key: index_key, filter_category: filter_category, from_document_date: from_document_date, to_document_date: to_document_date, counteragent_box_id: counteragent_box_id)
    end

    def get_documents(box : Entity::Box, index_key : String? = nil, filter_category : FilterCategory  = FilterCategory.default, from_document_date : Time? = nil, to_document_date : Time? = nil, counteragent_box : Entity::Box? = nil) : Entity::DocumentList
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetDocuments.fetch(client: self, box: box, index_key: index_key, filter_category: filter_category, from_document_date: from_document_date, to_document_date: to_document_date, counteragent_box: counteragent_box)
    end

    def get_entity_content(box : Entity::Box, message_id : String, entity_id : String)
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetEntityContent.fetch(self, box, message_id, entity_id)
    end

    def get_last_event(box : Entity::Box)
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetLastEvent.fetch(self, box)
    end

    def get_last_event(box_id : String)
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetLastEvent.fetch(self, box_id)
    end

    def get_my_organizations
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      @my_organizations ||= GetMyOrganizations.fetch(self)
    end

    def get_new_events(box : Entity::Box)
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetNewEvents.fetch(self, box)
    end

    def get_new_events(box_id : String)
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetNewEvents.fetch(self, box_id)
    end

    def get_organizations_by_inn_kpp(inn : String, kpp : String? = nil, include_relations : Bool? = nil) : Entity::OrganizationList
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetOrganizationsByInnKpp.fetch(self, inn, kpp, include_relations)
    end

    def post_message(message : Entity::MessageToPost)
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      PostMessage.fetch(self, message)
    end

    # Convenience methods

    def all_counteragents(organization : Entity::Organization) : Array(Entity::Counteragent)
      return @all_counteragents.not_nil! unless @all_counteragents.nil?
      i = 0
      @all_counteragents = [] of Entity::Counteragent
      while true
        r = get_counteragents(organization, i)
        break if r.counteragents.empty?
        @all_counteragents = @all_counteragents.not_nil! + r.counteragents
        i += 100
      end

      @all_counteragents.not_nil!
    end

    def all_documents(box : Entity::Box, index_key : String? = nil, filter_category : FilterCategory  = FilterCategory.default, from_document_date : Time? = nil, to_document_date : Time? = nil, counteragent_box : Entity::Box? = nil) : Array(Entity::Document)
      return @all_documents.not_nil! unless @all_documents.nil?
      index_key = ""
      @all_documents = [] of Entity::Document
      while true
        r = get_documents(box: box, index_key: index_key, filter_category: filter_category, from_document_date: from_document_date, to_document_date: to_document_date, counteragent_box: counteragent_box)
        @all_documents = @all_documents.not_nil! + r.documents
        if last = r.documents.last?
          index_key = last.index_key
        else
          break
        end
      end

      @all_documents.not_nil!
    end

    def first_box : Entity::Box?
      my_organization.try{ |org| org.boxes.first unless org.boxes.empty? }
    end

    def my_box(&block : Array(Entity::Box) -> Entity::Box) : Entity::Box?
      raise Exceptions::MethodNotSet.new("Сначала надо вызвать метод set_my_organization") unless @my_organization
      my_organization.try{ |org| yield(org.boxes) }
    end

    def my_organization : Entity::Organization?
      raise Exceptions::MethodNotSet.new("Сначала надо вызвать метод set_my_organization") unless @my_organization
      @my_organization
    end

    def set_my_organization(inn : String) : Entity::Organization?
      @my_organization ||= get_my_organizations.organizations.find{ |org| org.inn == inn }.as(Entity::Organization?)
    end
  end
end
