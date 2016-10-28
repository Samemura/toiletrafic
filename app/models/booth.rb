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
  has_paper_trail
  has_many :booth_usages
  has_many :booth_logs
  accepts_nested_attributes_for :booth_usages, :booth_logs

  enum state: {vacant:0, occupied:1, failed:2}
  after_update_commit { BoothBroadCastJob.perform_later(self); NotificationService.new(self).send; self.create_logs }

  def create_logs
    return unless self.state_changed("occupied", "vacant")
    BoothUsage.create_from_booth(self)
    BoothUsage.delete_olds
    BoothLog.create_from_booth(self)
    BoothLog.delete_olds
  end

  def state_changed(from, to)
    self.previous.state == from && self.state == to
  end

  def previous
    @previous ||= self.versions.last.reify
  end
end
