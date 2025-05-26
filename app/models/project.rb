class Project < ApplicationRecord
  enum :status, STATUS

  belongs_to :user
  has_many :conversation_events

  validates :title, presence: true
end
