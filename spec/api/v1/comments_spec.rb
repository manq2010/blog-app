require 'swagger_helper'

describe 'Api::V1::CommentsController', type: :request, swagger_doc: 'v1/swagger.json' do
  path '/users/{user_id}/posts/{post_id}/comments' do
    parameter name: 'user_id', in: :path, type: :integer, required: true
    parameter name: 'post_id', in: :path, type: :integer, required: true

    get 'List comments for a post' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :id, in: :query, type: :integer, required: false, description: 'Comment ID'
      response '200', 'list of comments for a post' do
        let(:user) { create(:user) }
        let(:post) { create(:post, user:) }
        let(:id) { create_list(:comment, 5, post:).pluck(:id).sample }
        let(:user_id) { user.id }
        let(:post_id) { post.id }
        run_test!
      end

      response '404', 'user or post not found' do
        let(:user_id) { 0 }
        let(:post_id) { 0 }
        let(:id) { 0 }
        run_test!
      end

      response '500', 'internal server error' do
        let(:user) { create(:user) }
        let(:post) { create(:post, user:) }
        let(:id) { create_list(:comment, 5, post:).pluck(:id).sample }
        let(:user_id) { user.id }
        let(:post_id) { post.id }
        before { allow_any_instance_of(Comment).to receive(:comments).and_raise(StandardError) }
        run_test!
      end
    end
  end
end
