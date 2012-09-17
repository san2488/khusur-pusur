require 'digest/sha2'

#pwd_salt = [Array.new(9){rand(256).chr}.join].pack('m').chomp
#pwd = Digest::SHA2.hexdigest('123456' + pwd_salt)
User.delete_all
User.create!({:name => 'Sujay', :email => 'sujay.narsale@gmail.com', :is_admin => true, :password => '123456'}, :without_protection=>true)#, :salt => pwd_salt, :created_at => DateTime::now, :updated_at => DateTime::now}, :without_protection => true)
User.create!({name: 'Mandar', email:'mschaudh@ncsu.edu', is_admin: false, password: '123456'}, :without_protection=>true)#, salt:pwd_salt, created_at: DateTime::now, updated_at: DateTime::now}, :without_protection => true)
User.create!({name: 'Altaf', email:'aspalana@ncsu.edu', is_admin: false, password: '123456'}, :without_protection=>true)#, salt:pwd_salt, created_at: DateTime::now, updated_at: DateTime::now}, :without_protection => true)

Category.delete_all
Category.create([{name: 'Ruby'}, {name: 'Java'}, {name: 'C++'}])