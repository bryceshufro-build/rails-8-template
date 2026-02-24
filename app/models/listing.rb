# == Schema Information
#
# Table name: listings
#
#  id           :bigint           not null, primary key
#  address      :string
#  available_on :date
#  bathrooms    :decimal(, )
#  bedrooms     :integer
#  description  :text
#  lease_end_on :date
#  monthly_rent :integer
#  neighborhood :string
#  status       :string
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  owner_id     :integer
#
class Listing < ApplicationRecord
end
