module ParamsSanitizer
  def register_user_attributes
    [
      :email,
      :password,
      :password_confirmation,
      :username,
      :name,
      :gender
    ]
  end
end