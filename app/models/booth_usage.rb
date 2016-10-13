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
  EXIPRE_PERIOD = 7.days.ago

  scope :created_at, ->(t=Time.now) { where(created_at: t) }

  belongs_to :booth

  class << self
    def by_hour(day=Date.today, hour_range: 8..19)
      self.created_at(day.to_time.all_day).group_by_hour_of_day(:created_at).sum(:use_minute).select_by_key_range(hour_range).value_to_percent(Booth.count*60)
    end

    def average_by_hour(period=1.month.ago..Time.now, hour_range: 8..19)
      days = ((period.last-period.first)/60/60/24).round
      self.created_at(period).group_by_hour_of_day(:created_at).sum(:use_minute).select_by_key_range(hour_range).value_to_percent(Booth.count*60*days)
    end

    def delete_olds
      self.where("created_at < ?", EXIPRE_PERIOD).delete_all
    end
  end
end
