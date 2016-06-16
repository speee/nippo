# frozen_string_literal: true
require 'google/apis/admin_directory_v1'

namespace :whitelist do
  desc 'generate whitelist via Google AdminSDK'
  task generate: :environment do
    new_whitelist = email_list(api_service)
    Whitelist::User.all.each do |user|
      user.destroy unless new_whitelist.member?(user.email)
    end
    new_whitelist.each do |email|
      Whitelist::User.find_or_create_by(email: email)
    end
  end

  GOOGLE_TOKEN_CREDENTIAL_URI = 'https://www.googleapis.com/oauth2/v3/token'

  def api_service
    service = Google::Apis::AdminDirectoryV1::DirectoryService.new
    service.authorization = Signet::OAuth2::Client.new(
      token_credential_uri: GOOGLE_TOKEN_CREDENTIAL_URI,
      client_id: Settings.google.whitelist_batch.api_client.id,
      client_secret: Settings.google.whitelist_batch.api_client.secret,
      refresh_token: Settings.google.whitelist_batch.refresh_token,
    )
    service.authorization.fetch_access_token!
    service
  end

  def email_list(api_service)
    res = []
    page_token = nil
    loop do
      api_res = api_service.list_members(Settings.google.whitelist_batch.target_group, page_token: page_token)
      api_res.members.each { |m| res << m.email }
      break unless page_token = api_res.next_page_token
    end
    res
  end
end
