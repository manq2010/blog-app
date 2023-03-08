require 'rails_helper'

RSpec.feature 'Post show page', type: :feature do
  let(:user_ids) { User.pluck(:id) }
  let(:post) { Post.first }
  before do
    visit user_post_path(user_id: user_ids.last, post_id: post.id)
  end

  scenario 'Displays details, show title and text for a post' do
    sleep(1)
    expect(page).to have_content('Hello')
    expect(page).to have_content('This is my first post')
    expect(page).to have_css('section', count: 1)
    expect(page).to have_css('button', count: 1)
  end

end
