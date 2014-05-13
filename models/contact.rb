class Contact
  attr_accessor :client_email_sent, :internal_email_sent, 
    :second_try, :third_try
  attr_reader :name, :email, :phone, :preferred, :message

  def initialize opts = {}
    opts.each { |k,v| instance_variable_set("@#{k}", v) }
    @client_email_sent = false
    @internal_email_sent = false
  end

  def save
    if third_try
      save_to_error_land
    elsif File.exists?('email_error.rb')
      File.write('email_error.rb', self.to_s + "\n", mode: 'w+')
    else
      File.write('email_error2.rb', self.to_s + "\n", mode: 'w+')
    end
  end

  def save_to_error_land
    File.write('error_land.rb', self.to_s + "\n", mode: 'w+')
  end

  def to_s
    stringified = "{:name=>#{name}, :email=>#{email}, :phone=>#{phone}, :preferred=>" +
    "#{preferred}, :message=>#{message}, :client_email_sent=> #{client_email_sent}, " +
    ":internal_email_sent=> #{internal_email_sent}, :second_try=> true"
    
    if second_try == true
      stringified += ", :third_try=> true}"
    else 
      stringified += "}"
    end
  end

  def send_emails gmail_password
    client_email_sent = send_client_email gmail_password
    internal_email_sent = send_internal_email gmail_password

    if !(client_email_sent && internal_email_sent)
      save
    end
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
end