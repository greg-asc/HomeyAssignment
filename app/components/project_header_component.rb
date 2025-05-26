# frozen_string_literal: true

class ProjectHeaderComponent < ViewComponent::Base
  attr_reader :title, :owner, :status, :created_at, :updated_at

  def initialize(project)
    @title      = project.title
    @owner      = project&.user&.email || "N/A"
    @status     = project.status
    @created_at = project.created_at
    @updated_at = project.updated_at
  end
end
