# frozen_string_literal: true

class ConversationEventFormComponent < ViewComponent::Base
  attr_reader :project, :user, :form

  def initialize(project:, user:, form: nil)
    @project = project
    @user = user
    @form = form || ConversationEventForm.new(project: @project, user: @user, params: {})
  end

  def valid_statuses_for_select
    STATUS.select { |st| st != @project.status }
          .map { |st| [ st.humanize, st ] }
  end

  # Define the Turbo Frame ID consistently
  def turbo_frame_id
    "new_project_event_form_#{project.id}"
  end
end
