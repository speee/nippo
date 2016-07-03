# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string(128)      not null
#  provider           :string(32)       not null
#  uid                :string(32)       not null
#  name               :string(64)       not null
#  image              :string(128)      not null
#  refresh_token      :string(128)      not null
#  sign_in_count      :integer          default(0), not null
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :string(255)
#  last_sign_in_ip    :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  devise :trackable, :timeoutable, :omniauthable
  has_one :template
  after_create :create_default_template

  def needing_tutorial?
    !template.user_updated?
  end

  def last_nippo
    @last_nippo ||= Nippo.where(user: self).order(reported_for: :desc).first
  end

  private

  def create_default_template
    Template.create_default(self)
  end

  class << self
    def find_for_google(auth)
      validate_auth!(auth)
      user = User.find_or_initialize_by(email: auth.info.email)

      user.provider         = auth.provider
      user.uid              = auth.uid
      user.name             = auth.info.name
      user.email            = auth.info.email
      user.image            = auth.info.image
      user.refresh_token    = auth.credentials.refresh_token
      user.save!

      user
    end

    private

    def validate_auth!(auth)
      email = auth.info.email
      if Settings.auth.use_whitelist
        throw "User #{email} is not allowed to access" unless Whitelist::User.find_by(email: email)
      else
        throw 'This service only for speee member' unless email.ends_with?('@speee.jp')
      end
    end
  end
end
