require 'mechanize'
namespace :leads do
  desc "sends leads to aquarian"
  task send_to_aquarian: :environment do
    Lead.all.where(:lead_sent=>false) each do |obj|
      mechanize = Mechanize.new
      landing_page = mechanize.get('https://creditstatusnow.com/Affiliates/Summary.aspx')
      login_form = landing_page.forms.first
      login_form["ctl00$Main$LoginName"] = 'aruns'
      login_form["ctl00$Main$LoginPassword"] = '45C4A90A9C'
      dashboard_page = login_form.submit(login_form.button_with(:value => "Submit") )
      lead_page_submission_page= dashboard_page.link_with(text: 'Send New Customer').click
      lead_form = lead_page_submission_page.forms.first
      validation_lambda = lambda {|x| '{"enabled":true,"emptyMessage":"","validationText":' << '"' << "#{x}" << '"' << ',"valueAsString":' << '"' << "#{x}" <<  '"' <<',"lastSetTextBoxValue":' <<  '"' <<"#{x}" << '"' << '}'}
      name_array = obj.name.strip.split(' ')
      first_name = name_array.first
      last_name = name_array.count == 1 ? "No Last Name is given" : name_array.last
      lead_form["ctl00$Main$FirstName"] = first_name
      lead_form["ctl00_Main_FirstName_ClientState"] = validation_lambda.call(first_name)
      lead_form["ctl00$Main$LastName"] = last_name
      lead_form["ctl00_Main_LastName_ClientState"] = validation_lambda.call(last_name)
      email = obj.email.strip
      lead_form["ctl00$Main$EmailAddress"] = email
      lead_form["ctl00_Main_EmailAddress_ClientState"] = validation_lambda.call(email)
      phone_number = obj.phone_number.tr("+","").to_s.strip
      lead_form["ctl00$Main$Phone_OpenText"] = phone_number
      lead_form["ctl00_Main_Phone_OpenText_ClientState"] = validation_lambda.call(phone_number)
      dashboard_page = lead_form.submit(lead_form.button_with(:value => "Send Now"))
      dashboard_page.link_with(text: '(Sign-out)').click
      obj.lead_sent = true
      obj.save
    end
  end
end
