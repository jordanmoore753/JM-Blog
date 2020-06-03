# create users

User.create!(name:     'Jondan',
             email:    'suckboot32@gmail.com',
             password: 'foob1!')

User.create!(name: 'Sucka', email: 'suckaberg@gmail.com', password: 'foob1!')

# create posts

me = User.first
him = User.last

3.times do |n|
  Post.create!(title: "Post #{n}", body: "This is the freaking #{n}th post!", user_id: me.id)
end

3.times do |n|
  Post.create!(title: "Post #{n + 4}", body: "This is the freaking #{n + 4}th post!", user_id: him.id)
end

# create comments

Post.all.each do |post|
  2.times do |n|
    Comment.create!(body: "This is the best #{n}th comment.", user_id: me.id, post_id: post.id)
  end

  2.times do |n|
    Comment.create!(body: "This is the best #{n + 2}th comment.", user_id: him.id, post_id: post.id)
  end
end
