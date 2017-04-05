User.create!(name:  "Dan Doughty",
             email: "dannydoughtz@yahoo.com",
             username: "ddoughty",
             password:              "bad_pass",
             password_confirmation: "bad_pass",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
             
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

videos = Video.order(:created_at).take(50)
50.times do
  content = Faker::Lorem.sentence(5)
  videos.each { |video| video.microposts.create!(content: content, user: User.last) }
end