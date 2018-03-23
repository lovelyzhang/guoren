class UserMailer < ApplicationMailer
  default from: "ucasguoren@heroku.com"

  def send_verify_code mail_address, code
    @verify_code = code
    mail(to: mail_address, subject: "验证码")
  end

end
