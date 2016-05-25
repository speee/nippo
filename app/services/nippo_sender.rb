# frozen_string_literal: true
require 'google/apis/gmail_v1'
require 'nkf'

class NippoSender
  include Virtus.model

  attribute :user,  User
  attribute :nippo, Nippo

  Gmail = Google::Apis::GmailV1
  ME = 'me'
  SUBJECT_ENCODING = '-wM'
  TEXT_PLANE = 'text/plain; charset=UTF-8'
  RFC822 = 'message/rfc822'

  def send
    gmail = Gmail::GmailService.new
    gmail.authorization = user.token

    message = RMail::Message.new
    message.header.to              = Settings.nippo.send_to
    message.header.from            = from
    message.header.subject         = NKF.nkf(SUBJECT_ENCODING, subject)
    message.header['Content-Type'] = TEXT_PLANE
    message.body = nippo.body

    gmail.send_user_message(ME,
      upload_source: StringIO.new(message.to_s),
      content_type: RFC822)

    nippo.update!(sent_at: Time.zone.now)
  end

  private

  def subject
    nippo.subject_yaml % nippo.reported_for.strftime('%Y/%m/%d')
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
