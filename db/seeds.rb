# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

emails = ['tpprajilkottur@gmail.com', 'aps.ashiqueps@gmail.com', 'nithindevnarayanan@gmail.com',
'astp114@gmail.com', 'nrn369@gmail.com', 'anees.ck@gmail.com', '
shyamraj.av@gmail.com', 'thushar.tmp@gmail.com', 'irshadkt.mec@gmail.com']

emails.each do |email|
  User.find_or_create_by(email: email)
end

event = Event.find_or_create_by(name: 'cleaning', max_no_of_user_per_group: 3, max_nof_groups: 3)
['team1', 'team2', 'team3'].each do |team|
  event.groups.find_or_create_by(name: team)
end
