json.array!(@booths) do |booth|
  json.extract! booth, :id, :state
end
