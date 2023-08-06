# rubocop:disable Style/ClassAndModuleChildren
class Devise::MailerPreview < ActionMailer::Preview
  def confirmation_instructions
    Devise::Mailer.confirmation_instructions(User.first, User.first.confirmation_token)
  end

  # def reset_password_instructions
  #   Devise::Mailer.reset_password_instructions(User.first, "faketoken")
  # end
  #
end
# rubocop:enable Style/ClassAndModuleChildren
