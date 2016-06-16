# frozen_string_literal: true
set :output, File.expand_path('../../log/cron.log', __FILE__)
set :environment, :production

every 1.day, at: '4:30 am' do
  rake 'whitelist:generate'
end
