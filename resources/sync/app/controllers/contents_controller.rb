class ContentsController < ApplicationController
  before_action :authorize_content, except: :index

  def index
    policy_scope(:content)
  end

  def authorize_content
    authorize :content, :show?
  end
end
