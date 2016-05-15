# frozen_string_literal: true
class PrivateController < ApplicationController
  before_action :authenticate_user!
end
