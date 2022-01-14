# The`TicksWrapper` is used to add context to Diadoc's Ticks time representation whilst preserving original value.
module DiadocApi
  module Entity
    module Wrappers
      class Ticks
        getter value : Int64
        getter time : Time?

        def initialize(@value : Int64)
          @time = init_time(@value)
        end

        def initialize(pull : JSON::PullParser)
          @value = pull.read_int
          @time = init_time(@value)
        end

        def init_time(v : Int64) : Time
          secs = (v / 10_000_000).round(Number::RoundingMode::TO_ZERO).to_i64
          nanos = (v % 10_000_000).to_i32
          Time.new(seconds: secs, nanoseconds: nanos, location: Time::Location::UTC)
        end
      end
    end
  end
end
