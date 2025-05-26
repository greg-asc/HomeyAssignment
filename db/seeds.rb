# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

users = Array.new(10) do |i|
  u = User.create email: "user#{i}@homey.co.uk", password: "SecretPassword1234!"
end

project = Project.create title: "Very Important Project", user: users[0]

reactions = %w[👍 ❤️ 🎉 😄 👀]

events = []

events << Comment.create!(
  project: project,
  user: users[1],
  body: "Looking forward to kicking this off. I suggest we clarify the goals before we get started.",
  created_at: 10.days.ago
)

events << StatusChange.create!(
  project: project,
  user: users[0],
  prev_status: 'starting',
  new_status: 'in_progress',
  created_at: 9.days.ago
)

events << Comment.create!(
  project: project,
  user: users[2],
  body: "Agreed — I’ve drafted an outline for the *initial deliverables*. Let me know your thoughts.",
  created_at: 8.days.ago
)

events << Comment.create!(
  project: project,
  user: users[3],
  body: "Started setting up the backend scaffolding. Using Hotwire for UI updates.",
  created_at: 7.days.ago
)

events << Comment.create!(
  project: project,
  user: users[4],
  body: "I'll handle the data model. Should we use STI for events or keep separate tables?",
  created_at: 6.days.ago
)

events << Comment.create!(
  project: project,
  user: users[5],
  body: "STI feels right given the unified conversation feed. Keeps queries simple.",
  created_at: 6.days.ago + 1.hour
)

events << Comment.create!(
  project: project,
  user: users[6],
  body: "Designs are in Figma — feedback welcome. Trying to keep it clean and minimal.",
  created_at: 5.days.ago
)

events << StatusChange.create!(
  project: project,
  user: users[0],
  prev_status: 'in_progress',
  new_status: 'under_review',
  created_at: 4.days.ago
)

events << Comment.create!(
  project: project,
  user: users[7],
  body: "Just reviewed the PR. Left some comments — mostly small UI tweaks.",
  created_at: 3.days.ago
)

events << Comment.create!(
  project: project,
  user: users[8],
  body: "Addressed the feedback. Also fixed a bug in the form object validations.",
  created_at: 2.days.ago
)

events << Comment.create!(
  project: project,
  user: users[9],
  body: "Nice work, team. Everything’s looking good on my end.",
  created_at: 1.day.ago
)

events << StatusChange.create!(
  project: project,
  user: users[0],
  prev_status: 'under_review',
  new_status: 'finished',
  created_at: 12.hours.ago
)

events << Comment.create!(
  project: project,
  user: users[1],
  body: "**Project complete!** 🎉 Great collaboration all around.",
  created_at: 10.hours.ago
)

events << StatusChange.create!(
  project: project,
  user: users[0],
  prev_status: 'finished',
  new_status: 'archived',
  created_at: 6.hours.ago
)

users.each do |user|
  events.sample(rand(1..5)).each do |event|
    Reaction.create!(
      user: user,
      reactable: event,
      reaction_type: reactions.sample,
      created_at: event.created_at + rand(5..300).seconds
    )
  end
end
