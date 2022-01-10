module DiadocApi
  struct Date
    DATE_FORMAT = "%d.%m.%Y"
    getter value : String

    # Инициализирует время в нужном формате из текущего
    def initialize
      @value = Time.local.to_s(DATE_FORMAT)
    end

    # Инициализирует время в нужном формате из JSON
    # Бросает ошибку если неправильный формат
    def initialize(puller : JSON::PullParser)
      @value = puller.read_string
      raise DateException.new("Дата должна быть в виде 31.12.2021") unless @value =~ /^\d{2}\.\d{2}\.20\d{2}$/
    end

    # Инициализирует время в нужном формате из строки
    # Формат 1 - 2021-01-02
    # Формат 2 - 02.01.2021
    # Бросает ошибку если неправильный формат
    def initialize(string : String)
      case string
      when /^20\d{2}-\d{2}-\d{2}$/ then @value = string
      when /^\d{2}\.\d{2}\.20\d{2}$/ then
        m = str.match(/^(\d{2})\.(\d{2})\.(20\d{2})$/).as(Regex::MatchData)
        @value = "#{m[3]}-#{m[2]}-#{m[1]}"
      else
        raise DateException.new("Дата должна быть в виде 31.12.2021")
      end
    end

    # Инициализирует время в нужном формате из стандартного Time
    def initialize(time : Time)
      @value = time.to_s(DATE_FORMAT)
    end

    # Переводит дату из выписки в стандартный Time
    def to_time : Time
      Time.parse(@value, DATE_FORMAT, Time::Location::UTC)
    end
  end

  class DateException < Exception
  end
end

struct Time
  def to_diadoc : DiadocApi::Date
    DiadocApi::Date.new(self)
  end
end
