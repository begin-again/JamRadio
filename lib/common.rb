
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

  def getOffset direction, offset, pgsize = 10
    o = offset.to_i
    o = 0 if o < 0
    if direction == :forward
      o += pgsize
    else
      if (o - pgsize) < 0
        o = 0
      else
        o -= pgsize
      end
    end
  end

end
