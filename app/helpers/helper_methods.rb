module HelperMethods
  def token
    SecureRandom.random_number(0o00000..999_999).to_s.rjust(4, '0')
  end

  def user_by_email
    @user_by_email ||= User.find_by(email: params[:email])
  end
end
