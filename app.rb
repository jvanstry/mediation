get '/' do
  @title = 'Home'
  puts settings.gmail_pw
  erb :home
end

get '/about' do
  @title = "about"
  erb :about
end

get '/rates' do

end

get '/contact' do

end

post '/contact' do
  puts params

  # Pony.mail({
  #   :to => 'jvanstry@gmail.com',
  #   :subject => 'We have received your request',
  #   :body => 'hello',
  #   :via => :smtp,
  #   :via_options => {
  #     :address              => 'smtp.gmail.com',
  #     :port                 => '587',
  #     :enable_starttls_auto => true,
  #     :user_name            => 'Mediation.WNY',
  #     :password             => '33Burlington',
  #     :authentication       => :plain, 
  #     :domain               => 'localhost' 
  #   }
  # })

end