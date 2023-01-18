class BoDeviseMailer < ApplicationMailer   
  helper :application
  include Devise::Controllers::UrlHelpers 

  def send_invitation(record)
    subject = 'Inscription nouvel utilisateur - back office '
    link = registration_admin_administrators_url(confirmation: record.reset_password_token)
    html = render partial: 'admin_mailer/send_invitation', locals: { link: }
    send_mail(recipients: record.email, subject:, html:)
  end

  def reset_password_instructions(record, token, opts = {})
    subject = "Changement de mot de passe - back office"
    html = render partial: 'devise/mailer/reset_password_instructions',
                  locals: {
                    resource: record,
                    token: token
                  }
    send_mail(recipients: record.email, subject:, html:)
  end
end
