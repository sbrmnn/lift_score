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
      validation_lamda = lamda {|x| '{"enabled":true,"emptyMessage":"","validationText":' << "#{x}" << ',"valueAsString":' << "#{x}" << ',"lastSetTextBoxValue":' <<  "#{x}" << '}'}
      name_array = obj.name.strip!.split(' ')
      first_name = name_array.first
      last_name = name_array.count == 1 ? "No Last Name is given" : name_array.last
      lead_form["ctl00$Main$FirstName"] = first_name
      lead_form["ctl00_Main_FirstName_ClientState"] = validation_lamda.call(first_name)
      lead_form["ctl00$Main$LastName"] = last_name
      lead_form["ctl00_Main_LastName_ClientState"] = validation_lamda.call(last_name)
      email = obj.email.strip!
      lead_form["ctl00$Main$EmailAddress"] = email
      lead_form["ctl00_Main_EmailAddress_ClientState"] = validation_lamda.call(email)
      phone_number = obj.phone_number.strip!
      lead_form["ctl00$Main$Phone_OpenText"] = phone_number
      lead_form["ctl00_Main_Phone_OpenText_ClientState"] = validation_lamda.call(phone_number)
      dashboard_page = lead_form.submit(lead_form.button_with(:value => "Send Now") )
      dashboard_page.link_with(text: '(Sign-out)').click
      obj.lead_sent = true
      obj.save
    end
  end
end


#<Lead id: 59, name: "Toni Lewellen", email: "T.edwards1908@gmail.com", phone_number: "+12144760354", lead_sent: false, created_at: "2015-04-11 17:44:40", updated_at: "2015-04-11 17:44:40">
