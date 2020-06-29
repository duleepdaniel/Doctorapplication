puts "Creating the Roles admin,doctor,nurse with doctor as default"		
Role.create!(name: 'admin')
Role.create!(name: 'doctor')
Role.create!(name: 'nurse')

puts "Initializing the Admin"
@user = User.create(
    :email => "admin@admin.com",
    :password => "qwerty",
    :password_confirmation => "qwerty")
@user.add_role "admin"
@user.save
puts "The Admin user with User_Id:admin@admin.com
		and password 'qwerty' has been Created"

