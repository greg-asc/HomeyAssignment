class ConversationEventsController < ApplicationController
  # include Pagy::Backend

  before_action :authenticate_user!

  def index
    @project = Project.find(params[:project_id])
    # TODO: @pagy, @events = pagy @project.conversation_events, items: 10
    @events = @project.conversation_events
  end

  def create
    @project = Project.find(params[:project_id])

    @form = ConversationEventForm.new(
      project: @project,
      user: current_user,
      params: event_params
    )

    if @form.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      # TODO: error messages
    end
  end

  private

  def event_params
    params.require(:event).permit(:type, :body, :new_status)
  end
end
