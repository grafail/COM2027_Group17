#
# config/initializers/scheduler.rb
require 'rufus-scheduler'

# Let's use the rufus-scheduler singleton
#
s = Rufus::Scheduler.singleton

# Awesome recurrent task...
#
# Don't run when testing
if not Rails.env.test?
  s.every '1h', :first_at => Time.now + 10 do
    MoneyRails.default_bank.update_rates
    Rails.logger.info "Currency exchange rates were updated!"
end

end