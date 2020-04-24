# General Settings
config.app_domain = 'somedomain.com'

# Email
config.action_mailer.delivery_method = :smtp
config.action_mailer.perform_deliveries = true
config.action_mailer.default_url_options = { host: config.app_domain }
config.action_mailer.smtp_settings = {
  address: 'smtp.gmail.com',
  port: '587',
  enable_starttls_auto: true,
  user_name: 'someuser',
  password: 'somepass',
  authentication: :plain,
  domain: 'somedomain.com'
}
