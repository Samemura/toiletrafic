class Booth < ApplicationRecord
  enum state: [:vacant, :occupied, :failed]
end
