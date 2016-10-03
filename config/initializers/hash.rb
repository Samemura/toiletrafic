class Hash
  def val_to_percent(max)
    self.map {|k, v|
      [k, (v.to_f*100/max).round]
    }.to_h
  end
end
