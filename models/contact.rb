class Contact
  attr_accessor :client_email_sent, :internal_email_sent
  attr_reader :name, :email, :phone, :preferred, :message

  def initialize opts = {}
    opts.each { |k,v| instance_variable_set("@#{k}", v) }
    @client_email_sent = false
    @internal_email_sent = false
  end

  def send_client_email email_password
    Pony.mail({
      :to => @email,
      :subject => 'We have received your request',
      :body => personalized_body,
      :via => :smtp,
      :via_options => {
        :address              => 'smtp.gmail.com',
        :port                 => '587',
        :enable_starttls_auto => true,
        :user_name            => 'Mediation.WNY',
        :password             => email_password,
        :authentication       => :plain, 
        :domain               => 'localhost' 
      }
    })
    true
  rescue
    false
  end

  def send_internal_email email_password
    Pony.mail({
      :to => 'mediation.wny@gmail.com',
      :subject => 'New Request Received',
      :body => contact_request,
      :via => :smtp,
      :via_options => {
        :address              => 'smtp.gmail.com',
        :port                 => '587',
        :enable_starttls_auto => true,
        :user_name            => 'Mediation.WNY',
        :password             => email_password,
        :authentication       => :plain, 
        :domain               => 'localhost' 
      }
    })
    true
  rescue
    false
  end



  private 

  def personalized_body
    "Hello #{name},\n\n" + 
    "Thanks for reaching out to VanStrydonck Mediation." + 
    " We have received your request for a consultation and will " +
    "be in touch shortly.\n\nBest,\nVanStrydonck Mediation"
  end

  def contact_request
    "Name: #{name}\nEmail: #{email}\nPhone: #{phone}\n" +
    "Preferred Contact Method: #{preferred}\nMessage: #{message.chomp.chomp}"
  end
end