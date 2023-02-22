class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  after_create :increment_user_posts_counter

  private

  def increment_user_posts_counter
    author.increment!(:posts_counter)
  end
end
