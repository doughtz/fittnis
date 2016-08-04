User.create!(name:  "Dan Doughty",
             email: "daniel.doughty@hotmail.com",
             username: "ddoughty",
             password:              "Banister768",
             password_confirmation: "Banister768",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

=begin             
Video.create!(
  title: "7/5/2016 20-Minute Workout",
  description: "Cardio workout for 20 minutes.",
  tags: "cardio",
  equipment: "dumbbells",
  videofile: "picture url",
  categor: "Cardio",
  length: 20*60,
  rating: 3,
  calories: 105,
  workouts: 1,
  workoutseconds: 1200,
  videolog: [],
  mediakey: "kDeYpg0U" )           

=end           
             
users = User.order(:created_at).take(6)
a = Time.now.strftime("%Y%m%d").to_i - 1
b = 0
c = 0
d = 0
50.times do
  title = Faker::Lorem.sentence(5)
  description = Faker::Lorem.sentence(5)
  tags = Faker::Lorem.sentence(5)
  equipment = Faker::Lorem.sentence(5)
  videofile = "kDeYpg0U"
  additional = "a"
  categor = Faker::Lorem.sentence(5)
  length = 12+b
  b += 1
  rating = 3
  calories = 105 + c
  c += 5
  workouts = 1
  workoutseconds = 50 + d
  d += 10
  videolog = []
  mediakey = a+1
  if mediakey % 100 > 30
    a = a+70
  else 
    a = a+1
  end
  
  users.each { |user| user.videos.create!(title: title, description: description,
                                          tags: tags, equipment: equipment, videofile: videofile,
                                          categor: categor, length: length, rating: rating, calories: calories, workouts: workouts, workoutseconds: workoutseconds,
                                          videolog: videolog, mediakey: mediakey) }
end