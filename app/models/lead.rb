class Lead < ActiveRecord::Base
  phony_normalize :phone_number, :default_country_code => 'US'
  validates_presence_of :name
  validates :email, :email => {:strict_mode => true} # Using email_validator gem to validate email field.
  validates_plausible_phone :phone_number, :presence => true
end
