# frozen_string_literal: true
Rails.application.config.generators do |g|
  g.stylesheets false
  g.javascripts false
  g.helper false
  g.template_engine = :slim
  g.helper_specs = false
  g.view_specs = false
  g.factory_girl dir: 'spec/factories'
end
