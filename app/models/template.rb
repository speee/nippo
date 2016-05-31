# frozen_string_literal: true
# == Schema Information
#
# Table name: templates
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  subject_yaml :text(65535)
#  body         :text(65535)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  from_name    :string(64)
#
# Indexes
#
#  index_templates_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_68700cea77  (user_id => users.id)
#

class Template < ApplicationRecord
  belongs_to :user

  def self.create_default(user)
    create(user:         user,
           subject_yaml: Settings.template.default.subject_yaml,
           body:         Settings.template.default.body,
           from_name:    user.name)
  end
end
