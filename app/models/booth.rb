# == Schema Information
#
# Table name: booths
#
#  id         :integer          not null, primary key
#  state      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Booth < ApplicationRecord
  MINUTES_IN_HOUR = 60

  has_paper_trail
  has_many :booth_usages
  accepts_nested_attributes_for :booth_usages

  enum state: {vacant:0, occupied:1, failed:2}
  after_update_commit { BoothBroadCastJob.perform_later(self); self.create_usage; BoothUsage.delete_olds }

  def create_usage
    prev = self.versions.last.reify
    if self.state_changed(prev, "occupied", "vacant")
      self.used_minutes(prev).each do |k, v|
        self.booth_usages.create(created_at: k, use_minute: v)
      end
    end
  end

  def state_changed(prev, from, to)
    prev.state == from && self.state == to
  end

  def used_minutes(prev)
    used_min_div, used_min_mod = ((self.updated_at - prev.updated_at)/60).round.divmod(MINUTES_IN_HOUR)
    updated_min = self.updated_at.min
    result = {self.updated_at => used_min_mod}
    ((result.count)..used_min_div).each do |i|
      result[self.updated_at-i.hour] = MINUTES_IN_HOUR
    end

    if updated_min < used_min_mod
      result[self.updated_at] = updated_min
      result[self.updated_at-result.count.hour] = used_min_mod - updated_min
    end

    return result
  end
end
