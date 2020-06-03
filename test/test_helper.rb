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
  def populate_db
    User.all.each { |user| generate_posts(user.id) }
    create_comments_for_posts
  end

  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in_as(user)
    session[:user_id] = user.id
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

class ActionDispatch::IntegrationTest
  def log_in_as(user, password: 'foob1!')
    post login_path, params: { email: user.email, password: password }
  end
end