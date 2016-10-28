# == Schema Information
#
# Table name: booth_usages
#
#  id         :integer          not null, primary key
#  use_minute :integer
#  booth_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_booth_usages_on_booth_id  (booth_id)
#

class BoothUsage < ApplicationRecord
  MINUTES_IN_HOUR = 60
  EXPIRE_PERIOD = 8.days.ago.at_end_of_day

  scope :created_at, ->(t=Time.now) { where(created_at: t) }
  scope :without_day_of_week, ->(day) { where("DAYOFWEEK(created_at) != ?", day)}

  belongs_to :booth

  class << self
    def create_from_booth(booth)
      used_min_div, used_min_mod = ((booth.updated_at - booth.previous.updated_at)/60).round.divmod(MINUTES_IN_HOUR)
      updated_min = booth.updated_at.min
      result = {booth.updated_at => used_min_mod}
      ((result.count)..used_min_div).each do |i|
        result[booth.updated_at-i.hour] = MINUTES_IN_HOUR
      end

      if updated_min < used_min_mod
        result[booth.updated_at] = updated_min
        result[booth.updated_at-result.count.hour] = used_min_mod - updated_min
      end

      result.each do |k, v|
        self.create(created_at: k, use_minute: v)
      end
    end

    def by_hour(day=Date.today, hour_range: 8..19)
      self.created_at(day.to_time.all_day).group_by_hour_of_day(:created_at).sum(:use_minute).select_by_key_range(hour_range).value_to_percent(Booth.count*60)
    end

    def average_by_hour(period=EXPIRE_PERIOD..1.day.ago.at_end_of_day, hour_range: 8..19)
      days = ((period.last-period.first).to_f/60/60/24) - self.weekends(period)
      self.created_at(period).without_day_of_week(1).without_day_of_week(7).group_by_hour_of_day(:created_at).sum(:use_minute).select_by_key_range(hour_range).value_to_percent(Booth.count*60*days)
    end

    def delete_olds
      self.where("created_at < ?", EXPIRE_PERIOD).delete_all
    end

    def weekends(period)
      period.first.to_datetime.step(period.last.to_datetime, 1).inject(0){|sum, p| sum + ([0,6].include?(p.wday) ? 1 : 0)}
    end
  end
end
