class ExampleMailer < ApplicationMailer
  default from: "andrea@onextra.ca"

  def sample_email(user)
    @user = user
    mail(to: @user.email, subject: 'Sample Email')
  end
end
