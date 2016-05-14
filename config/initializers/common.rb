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

Rails.application.config.time_zone = 'Tokyo'
Rails.application.config.active_record.default_timezone = :local
# Rails.application.config.i18n.default_locale = :ja
