# frozen_string_literal: true

class CommentComponent < ViewComponent::Base
  attr_reader :body, :user_name, :created_at, :markdown

  def initialize(comment, options = {})
    @body       = comment.body
    @user_name  = comment.user.email
    @created_at = comment.created_at
    @markdown   = options[:md_renderer]
  end
end
