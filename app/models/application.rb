class Application < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  has_many :messages, dependent: :destroy
end
