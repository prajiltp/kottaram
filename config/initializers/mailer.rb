ActionMailer::Base.smtp_settings = {
  user_name: 'prajilkottur',
  password: 'Year2017',
  domain: 'kottaram.tk',
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
