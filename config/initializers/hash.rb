class Hash
  def value_to_percent(max)
    self.map {|k, v|
      [k, (v.to_f*100/max).round]
    }.to_h
  end
  def select_by_key_range(range)
    self.select{|k,_| range.include?(k)}
  end
end
