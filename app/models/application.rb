# == Schema Information
#
# Table name: applications
#
#  id               :bigint           not null, primary key
#  decision_notes   :text
#  message_to_owner :text
#  priority_rank    :integer
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  listing_id       :integer
#  user_id          :integer
#
class Application < ApplicationRecord
end
