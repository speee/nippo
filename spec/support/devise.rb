# frozen_string_literal: true
module PrivateControllerTestHelpers
  extend RSpec::SharedContext

  let(:current_user) { FG.create(:user) }
end

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include PrivateControllerTestHelpers, type: :controller
  config.before(:each, type: :controller) do
    sign_in current_user
  end
end
