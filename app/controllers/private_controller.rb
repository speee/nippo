# frozen_string_literal: true
class PrivateController < ApplicationController
  layout 'private'
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |_|
    raise ActionController::RoutingError, 'Not Found'
  end
end
