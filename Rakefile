require('./models/contact.rb')

namespace :data do
  task :email_errors do
    if File.exists?('email_error.rb')
      file = 'email_error.rb'
    else
      file = 'email_error2.rb'
    end

    File.open(file, 'r+') do |f|
      while line = f.gets
        contact_info = line.gsub(/[{}:]/,'').split(', ')
          .map{|h| h1,h2 = h.split('=>'); {h1 => h2}}.reduce(:merge)

        contact = Contact.new(contact_info)
        contact.send_emails ENV['gmail_password']
      end
      
      File.delete(file)
    end
  end  
end