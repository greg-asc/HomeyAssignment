class ConversationEventForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :body, :string
  attribute :new_status, :integer

  attr_reader :project, :user, :event

  def initialize(project:, user:, params:)
    @project    = project
    @user       = user
    @type       = params[:type]
    @body       = params[:body]
    @new_status = params[:new_status]
  end

  validate :must_be_comment_or_status_change
  validate :valid_status_value, if: :status_change_submission?

  def save
    ActiveRecord::Base.transaction do
      build_event_and_update_project!
    rescue ActiveRecord::RecordInvalid => e
      errors.add(:base, e.message)
      raise ActiveRecord::Rollback
    rescue StandardError => e
      errors.add(:base, "An unexpected error occurred: #{e.message}")
      raise ActiveRecord::Rollback
    end

    true
  end

  private

  def comment_submission?
    @body.present?
  end

  def status_change_submission?
    @new_status.present? && @body.blank?
  end

  def must_be_comment_or_status_change
    unless comment_submission? || status_change_submission?
      errors.add(:base, "Please provide either a comment or a new status.")
    end

    if @body.present? && @new_status.present?
      errors.add(:base, "Ambiguous event data.")
    end
  end

  def valid_status_value
    unless Project.statuses.keys.include?(new_status)
       errors.add(:new_status, "'#{new_status}' is not a valid status.")
    end

    if project.status == new_status
      errors.add(:new_status, "Project is already in status '#{new_status}'.")
    end
  end


  def build_event_and_update_project!
    if comment_submission?
      @event = Comment.create!(
        project: @project,
        user: @user,
        body: @body
      )
    elsif status_change_submission?
      prev_status = project.status

      @event = StatusChange.create!(
        project: @project,
        user: @user,
        prev_status: prev_status,
        new_status: @new_status
      )
    end
  end
end
