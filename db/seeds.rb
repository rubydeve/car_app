# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



roles = ["owner","driver"]
role_id = 1
roles.each do |role|
  puts"role "

  al = Role.find_by_name(role)
  if al.blank?
    Role.create(id: role_id, name: role)
    role_id = role_id + 1
  end
end