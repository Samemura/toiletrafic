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

  after_update_commit { BoothBroadCastJob.perform_later self }
  enum state: {vacant:0, occupied:1, failed:2}
end
