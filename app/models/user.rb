# frozen_string_literal: true
class User < ApplicationRecord
  devise :trackable, :omniauthable

  class << self
    def find_for_google(auth)
      validate_auth!(auth)
      user = User.find_or_initialize_by(email: auth.info.email)

      user.provider = auth.provider
      user.uid      = auth.uid
      user.name     = auth.info.name
      user.email    = auth.info.email
      user.image    = auth.info.image
      user.token    = auth.credentials.token
      user.save!

      user
    end

    private

    def validate_auth!(auth)
      throw 'This service only for speee member' unless auth.info.email.ends_with?('@speee.jp')
    end
  end
end
