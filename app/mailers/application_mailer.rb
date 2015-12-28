class ApplicationMailer < ActionMailer::Base
  def self.no_reply_email_address
    name = "(Service Manual) DON'T REPLY"
    if GovukAdminTemplate.environment_label !~ /production/i
      name.prepend("[GOV.UK #{GovukAdminTemplate.environment_label}] ")
    end

    address = Mail::Address.new("inside-government@digital.cabinet-office.gov.uk")
    address.display_name = name
    address.format
  end

  default from: no_reply_email_address
  layout 'mailer'
end
