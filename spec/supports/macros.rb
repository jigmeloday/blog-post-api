# frozen_string_literal: true

def sign_in(user)
  post user_session_url, params: { user: { login: user.email, password: user.password } }
end

def sign_in_with_pwd(user, pwd)
  post user_session_url, params: { user: { login: user.email, password: pwd } }
end

def json
  result = JSON.parse(response.body)
  result.is_a?(Array) ? result : HashWithIndifferentAccess.new(result)
end

def load_task(task)
  Rails.application.load_tasks
  Rake::Task[task].execute
end
