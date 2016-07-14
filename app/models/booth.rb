class Booth < ApplicationRecord
  after_update_commit { BoothBroadCastJob.perform_later self }
  enum state: [:vacant, :occupied, :failed]
end
