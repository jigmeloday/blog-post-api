# frozen_string_literal: true

class DeviseMailer < Devise::Mailer
  layout 'mailer'

  def confirmation_instructions(record, token, opts = {})
    @token = record.confirmation_token
    opts[:subject] = 'Confirmation code'
    opts[:from] = 'Otter Whispers'
    super
  end

  # def send_reset_password_code(user)
  #   @token = user.reset_password_token
  #   mail(
  #     to: user.email,
  #     from: "NIP NaykapGokab",
  #     subject: 'Reset password code'
  #   )
  # end
end
