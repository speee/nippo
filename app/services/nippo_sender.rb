# frozen_string_literal: true
require 'google/apis/gmail_v1'
require 'nkf'

class NippoSender
  include Virtus.model

  attribute :user,  User
  attribute :nippo, Nippo

  Gmail = Google::Apis::GmailV1
  GOOGLE_TOKEN_CREDENTIAL_URI = 'https://www.googleapis.com/oauth2/v3/token'
  ME = 'me'
  SUBJECT_ENCODING = '-wM'
  TEXT_PLANE = 'text/plain; charset=UTF-8'
  RFC822 = 'message/rfc822'

  def send
    message = RMail::Message.new
    message.header.to              = Settings.nippo.send_to
    message.header.from            = from
    message.header.subject         = NKF.nkf(SUBJECT_ENCODING, nippo.dated_subject)
    message.header['Content-Type'] = TEXT_PLANE
    message.body = nippo.body

    message.header.cc = user.template.cc if user.template.cc.present?

    gmail_service.send_user_message(ME,
      upload_source: StringIO.new(message.to_s),
      content_type: RFC822)

    nippo.update!(sent_at: Time.zone.now)
  end

  private

  def gmail_service
    gmail = Gmail::GmailService.new
    gmail.authorization = Signet::OAuth2::Client.new(
      token_credential_uri: GOOGLE_TOKEN_CREDENTIAL_URI,
      client_id: Settings.google.web_main.api_client.id,
      client_secret: Settings.google.web_main.api_client.secret,
      refresh_token: user.refresh_token,
    )
    gmail.authorization.fetch_access_token!
    gmail
  end

  def from
    if user.template.from_name.present?
      from_jp = "#{user.template.from_name} <#{user.email}>"
      NKF.nkf(SUBJECT_ENCODING, from_jp)
    else
      user.email
    end
  end
end
