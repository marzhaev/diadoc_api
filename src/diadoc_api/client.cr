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

    def get_content(type_name_id : String? = nil, function : String? = nil, version : String? = nil, title_index : String? = nil, content_type : String? = nil)
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetContent.fetch(self, type_name_id, function, version, title_index, content_type)
    end

    def get_counteragents(organization : Entity::Organization, index_key : Int32? = nil) : Entity::CounteragentList
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetCounteragents.fetch(self, organization, index_key)
    end

    def get_document(box : Entity::Box, messageId : String, entityId : String)
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetDocument.fetch(self, box, messageId, entityId)
    end

    def get_document_types(box : Entity::Box)
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetDocumentTypes.fetch(self, box)
    end

    def get_documents(box : Entity::Box, index_key : String?, filter_category : FilterCategory, counteragent_box : Entity::Box?) : Entity::DocumentList
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetDocuments.fetch(client: self, box: box, index_key: index_key, filter_category: filter_category, counteragent_box: counteragent_box)
    end

    def get_entity_content(box : Entity::Box, messageId : String, entityId : String)
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      GetEntityContent.fetch(self, box, messageId, entityId)
    end

    def get_my_organizations
      raise Exceptions::Unauthenticated.new("Не авторизован") unless @session_token
      @my_organizations ||= GetMyOrganizations.fetch(self)
    end

    # Convenience methods

    def all_counteragents(organization : Entity::Organization) : Array(Entity::Counteragent)
      return @all_counteragents.not_nil! unless @all_counteragents.nil?
      i = 0
      @all_counteragents = [] of Entity::Counteragent
      while
        r = get_counteragents(organization, i)
        @all_counteragents = @all_counteragents.not_nil! + r.counteragents
        break if r.total_count < 0
        i += 100
      end

      @all_counteragents.not_nil!
    end

    def all_documents(box : Entity::Box?, filter_category : FilterCategory, counteragent_box : Entity::Box? = nil) : Array(Entity::Document)
      return @all_documents.not_nil! unless @all_documents.nil?
      index_key = ""
      @all_documents = [] of Entity::Document
      while
        r = get_documents(box: box, index_key: index_key, filter_category: filter_category, counteragent_box: counteragent_box)
        if last = r.documents.last?
          index_key = last.index_key
        else
          break
        end
        @all_documents = @all_documents.not_nil! + r.documents
      end

      @all_documents.not_nil!
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
