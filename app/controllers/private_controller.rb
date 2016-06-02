# frozen_string_literal: true
class PrivateController < ApplicationController
  layout 'private'
  before_action :authenticate_user!
end
