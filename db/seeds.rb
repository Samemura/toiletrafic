BoothUsage.delete_all
now = DateTime.now.at_beginning_of_hour - 0.5.minute

(1..4).each do |i|
  booth = Booth.find_or_create_by(id: i) do |b|
    b.state = "vacant"
  end
  ActiveRecord::Base.transaction do
    (now-7.days).step(now, 1.0/24/2).each do |t|
      booth.booth_usages.create(created_at: t, use_minute: Random.rand(30))
    end
  end
end
