class StatusChange < ConversationEvent
  enum :prev_status, STATUS, instance_methods: false
  enum :new_status, STATUS, instance_methods: false

  validates :prev_status, presence: true
  validates :new_status, presence: true
  validate :status_must_change

  after_commit :apply_project_status_change, on: :create

  private

  def status_must_change
    errors.add(:new_status, "must be different from previous status") if prev_status == new_status
  end

  def apply_project_status_change
    return if project.blank? || new_status.blank?

    project.update! status: new_status
  end
end
