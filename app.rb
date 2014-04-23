get '/' do
  @title = 'home'
  erb :home
end

get '/about' do
  erb :about
end

get '/rates' do
  erb :rates
end

get '/contact' do
  erb :contact
end

post '/contact' do
  contact = Contact.new params[:contact]
  
  contact.client_email_sent = contact.send_client_email ENV['gmail_password']
  contact.internal_email_sent = contact.send_internal_email ENV['gmail_password']

  # contact.save
  
  erb :home
end