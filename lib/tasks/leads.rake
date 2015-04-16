require 'mechanize'
namespace :leads do
  desc "sends leads to aquarian"
  task send_to_aquarian: :environment do
    mechanize = Mechanize.new
    landing_page = mechanize.get('https://creditstatusnow.com/Affiliates/Summary.aspx')
    login_form = landing_page.forms.first
    login_form["ctl00$Main$LoginName"] = 'aruns'
    login_form["ctl00$Main$LoginPassword"] = '45C4A90A9C'
    dashboard_page = login_form.submit(login_form.button_with(:value => "Submit") )
    lead_page_submission_page= dashboard_page.link_with(text: 'Send New Customer').click
    lead_form = lead_page_submission_page.forms.first
    lead_form["ctl00$Main$FirstName"] = name.split(' ').first
    first_name_validation = '{"enabled":true,"emptyMessage":"","validationText":' << "#{name.split(' ').first}" << ',"valueAsString":' << "#{name.split(' ').first}" << ',"lastSetTextBoxValue":' <<  "#{name.split(' ').first}" << '}'
    lead_form["ctl00_Main_FirstName_ClientState"] = first_name_validation
    lead_form["ctl00$Main$LastName"] = 'Tye'
    lead_form["ctl00_Main_LastName_ClientState"] = '{"enabled":true,"emptyMessage":"","validationText":"Tye","valueAsString":"Tye","lastSetTextBoxValue":"Tye"}'

    lead_form["ctl00$Main$EmailAddress"] = 'sylviatye@yahoo.com'
    lead_form["ctl00_Main_EmailAddress_ClientState"] = '{"enabled":true,"emptyMessage":"","validationText":"sylviatye@yahoo.com","valueAsString":"sylviatye@yahoo.com","lastSetTextBoxValue":"sylviatye@yahoo.com"}'
    lead_form["ctl00$Main$Phone_OpenText"] = '19035049802'
    lead_form["ctl00_Main_Phone_OpenText_ClientState"] = '{"enabled":true,"emptyMessage":"","validationText":"19035049802","valueAsString":"19035049802","lastSetTextBoxValue":"19035049802"}'
    dashboard_page = lead_form.submit(lead_form.button_with(:value => "Send Now") )
    dashboard_page.link_with(text: '(Sign-out)').click
  end
end


#<Lead id: 59, name: "Toni Lewellen", email: "T.edwards1908@gmail.com", phone_number: "+12144760354", lead_sent: false, created_at: "2015-04-11 17:44:40", updated_at: "2015-04-11 17:44:40">
