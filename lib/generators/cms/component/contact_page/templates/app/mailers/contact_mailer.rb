class ContactMailer < ActionMailer::Base
  def contact_email(attributes)
    @attributes = attributes

    mail(
      from: 'from@example.com',
      to: 'to@example.com',
      subject: 'Contact Form Submission'
    )
  end
end
