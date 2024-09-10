users_ids = User.pluck(:id)
communities_ids = Community.pluck(:id)

# Create Submissions
20.times do
  Submission.create(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    user_id: users_ids.sample,
    community_id: communities_ids.sample
  )
end