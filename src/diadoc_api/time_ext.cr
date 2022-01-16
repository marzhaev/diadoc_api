struct Time
  def to_diadoc : Int64
		total_seconds * 10_000_000 + nanosecond
  end
end
