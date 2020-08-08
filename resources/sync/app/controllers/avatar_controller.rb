# frozen_string_literal: true

class AvatarController < ApplicationController
  include LetterAvatar::AvatarHelper

  def name
    authorize :dashboard, :show?

    # rubocop:disable Lint/NumberConversion
    size = params[:s].to_i
    size = 32 if size.zero?
    # rubocop:enable Lint/NumberConversion

    send_file(
      letter_avatar_for(params[:full_name], size),
      type: 'image/png'
    )
  end
end
