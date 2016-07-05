# frozen_string_literal: true
# == Schema Information
#
# Table name: templates
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  subject    :text(65535)
#  body       :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  from_name  :string(64)
#  cc         :text(65535)
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

  validates :subject, presence: true

  def cc=(val)
    ary = RMail::Address.parse(val).format
    joined = ary.empty? ? nil : ary.join(',')
    super(joined)
  end

  def self.create_default(user)
    create(user:      user,
           subject:   Settings.template.default.subject,
           body:      Settings.template.default.body,
           from_name: user.name)
  end

  def user_updated?
    updated_at > created_at
  end
end
