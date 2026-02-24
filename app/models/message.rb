# == Schema Information
#
# Table name: messages
#
#  id             :bigint           not null, primary key
#  body           :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  application_id :integer
#  sender_id      :integer
#
class Message < ApplicationRecord
end
