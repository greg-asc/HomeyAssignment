# frozen_string_literal: true

class StatusChangeComponent < ViewComponent::Base
  attr_reader :prev_status, :new_status, :user_name, :created_at

  def initialize(event)
    @prev_status = event.prev_status
    @new_status  = event.new_status
    @user_name   = event.user.email
    @created_at  = event.created_at
  end
end
