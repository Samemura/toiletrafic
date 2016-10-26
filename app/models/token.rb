# == Schema Information
#
# Table name: tokens
#
#  id         :integer          not null, primary key
#  token      :string(255)
#  platform   :string(191)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tokens_on_platform  (platform)
#

class Token < ApplicationRecord
  scope :android, -> () { where(platform: "android") }
  scope :ios, -> () { where(platform: "ios") }

  scope :tokens, -> () { pluck(:token) }
end
