module DiadocApi
  module Entity
    class TimeBasedFilter
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("FromTimestamp?", Timestamp)
      diadoc_property("ToTimestamp?", Timestamp)
      diadoc_property("SortDirection?", SortDirection)

      def initialize(@from_timestamp : Timestamp? = nil, @to_timestamp : Timestamp? = nil, @sort_direction : SortDirection? = SortDirection::Descending)
      end
    end

    class Timestamp
      include JSON::Serializable
      include JSON::Serializable::Strict

      diadoc_property("Ticks", Int64)

      def initialize(time = Time)
        @ticks = time.to_diadoc
      end

      def time : Time?
        Wrappers::Ticks.new(@ticks).time
      end
    end

    # Порядок сортировки событий по метке времени
    # UnknownSortDirection - зарезервировано Диадоком
    enum SortDirection
      UnknownSortDirection
      Ascending
      Descending
    end
  end
end
