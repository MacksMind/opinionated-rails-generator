class ContentsController < ApplicationController
  skip_authorization_check

  def show
    if params[:id]
      @content = Content.find_by_slug(params[:id])
    else
      @content = Content.order(:position).limit(1).first
    end
    raise ActionController::RoutingError.new("No route matches \"#{request.path}\"") if !@content
    @page_title = @content.title
    case @content.html[0]
    when '='
      eval(@content.html[1..-1])
    when ':'
      render @content.html[1..-1]
    end
  end
end
