# frozen_string_literal: true
class WelcomesController < ApplicationController
  def show
  end

  def sign_out
    reset_session
    flash[:notice] = t('devise.sessions.signed_out')
    redirect_to welcome_path
  end
end
