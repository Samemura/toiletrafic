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
  belongs_to :booth

  class << self
    def hourly_usage
      self.group_by_hour(:created_at).sum(:use_minute).val_to_percent(Booth.count*60)
    end

    def delete_olds
      self.where("created_at < ?", 7.days.ago).delete_all
    end
  end
end
