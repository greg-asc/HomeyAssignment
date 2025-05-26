class Comment < ConversationEvent
  validates :body, presence: true
end
