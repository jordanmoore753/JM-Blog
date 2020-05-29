ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!
class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def populate_db()
    User.all.each { |user| generate_posts(user.id) }
    create_comments_for_posts
  end

  private

  def generate_posts(user_id)
    10.times do |n|
      Post.create!({
        body: "This is the #{n}th post.",
        user_id: user_id,
        title: "Post #{n}"
      })
    end
  end

  def create_comments_for_posts
    Post.all.each { |post| generate_comments(post) }
  end

  def generate_comments(post)
    5.times do |n|
      Comment.create!({
        post_id: post.id,
        user_id: post.user_id,
        body: "This is the #{n}th comment."
      })
    end
  end
end
