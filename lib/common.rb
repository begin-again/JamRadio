
module Common

  def parse_integer n
    if n.respond_to?( :to_i )
      n.to_i
    else
      raise ArgumentError, "Requires an integer"
    end
  end

  def parse_date d
    if d.respond_to?(:to_date)
        d.to_date
    else
      begin
        Date.parse(d.to_s)
      rescue
        raise ArgumentError, 'Expected Date or Date String'
      end
    end
  end

end
