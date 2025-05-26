class ConversationEventPresenter
  attr_reader :component, :markdown

  def initialize(event)
    @component =
      case event
      when StatusChange
        StatusChangeComponent.new event
      when Comment
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
        CommentComponent.new event, md_renderer: markdown
      end
  end
end
