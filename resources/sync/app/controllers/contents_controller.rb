class ContentsController < ApplicationController
  skip_authorization_check

  def index
    if signed_in?
      redirect_to user_root_path
    end
  end
end
