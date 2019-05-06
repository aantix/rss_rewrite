module Loggable
  def logx(message)
    puts(":xxx: #{Time.now.to_s} :: #{message}") if Rails.env.development?
  end
end