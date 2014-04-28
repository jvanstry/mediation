get '/' do
  @title = 'home'
  erb :home
end

get '/about' do
  @title = 'about'
  erb :about
end

get '/rates' do
  @title = 'rates'
  erb :rates
end

get '/contact' do
  @title = 'contact'
  erb :contact
end

get '/services' do
  @title = 'services'
  erb :services
end

post '/contact' do
  contact = Contact.new params[:contact]
  
  contact.client_email_sent = contact.send_client_email ENV['gmail_password']
  contact.internal_email_sent = contact.send_internal_email ENV['gmail_password']

  # TODO contact.save
  # TODO flash -> Thanks for the submission
  # TODO validations
  # TODO spinner on email submit
  
  redirect '/'
end