get '/' do
  @title = 'Home'
  erb :home
end

get '/about' do
  @title = "about"
  erb :about
end

get '/rates' do

end

get '/contact' do
  erb :contact
end

post '/contact' do
  contact = Contact.new params[:contact]
  
  contact.client_email_sent = contact.send_client_email settings.gmail_pw
  contact.internal_email_sent = contact.send_internal_email settings.gmail_pw

  # contact.save
  
  erb :home
end