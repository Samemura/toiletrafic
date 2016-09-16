class Booth < ApplicationRecord
  after_update_commit { BoothBroadCastJob.perform_later self }
  enum state: {vacant:0, occupied:1, failed:2}

end
