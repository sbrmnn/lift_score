class Lead < ActiveRecord::Base
  phony_normalize :phone_number, :default_country_code => 'US'
  validates_presence_of :name
  validates :email, :email => {:strict_mode => true} # Using email_validator gem to validate email field.
  validates_plausible_phone :phone_number, :presence => true
  after_commit :send_mail


  def send_mail
    email_msg = "Hi Arun,\n Here is your lead #{self.name} #{self.email} #{self.phone_number}"
    ActionMailer::Base.mail(:from => "noreply@liftscore.com", :to => ENV["MYEMAIL"], :subject => "New Lead", :body => email_msg).deliver
  end
end
