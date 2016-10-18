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
  EXPIRE_PERIOD = 8.days.ago.at_end_of_day

  scope :created_at, ->(t=Time.now) { where(created_at: t) }
  scope :without_day_of_week, ->(day) { where("DAYOFWEEK(created_at) != ?", day)}

  belongs_to :booth

  class << self
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
