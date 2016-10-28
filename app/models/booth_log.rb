# == Schema Information
#
# Table name: booth_logs
#
#  id            :integer          not null, primary key
#  start_time    :datetime
#  end_time      :datetime
#  duration_secs :integer
#  booth_id      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_booth_logs_on_booth_id  (booth_id)
#

class BoothLog < ApplicationRecord
  EXPIRE_PERIOD = 14.days.ago.at_end_of_day
  belongs_to :booth

  class << self
    def create_from_booth(booth)
      s = booth.previous.updated_at
      e = booth.updated_at
      self.create(
        start_time: s,
        end_time: e,
        duration_secs: e - s,
        booth: booth
      )
    end

    def delete_olds
      self.where("created_at < ?", EXPIRE_PERIOD).delete_all
    end
  end
end
