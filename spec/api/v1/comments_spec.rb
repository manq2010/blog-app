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
        let(:id) { create_list(:comment, 5, post:)).pluck(:id).sample }
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
        let(:id) { create_list(:comment, 5, post:)).pluck(:id).sample }
        let(:user_id) { user.id }
        let(:post_id) { post.id }
        before { allow_any_instance_of(Comment).to receive(:comments).and_raise(StandardError) }
        run_test!
      end
    end
  end

  path '/users/{user_id}/posts/{post_id}/comments/{id}' do
  parameter name: 'user_id', in: :path, type: :integer, required: true
    parameter name: 'post_id', in: :path, type: :integer, required: true
    parameter name: 'id', in: :path, type: :integer, required: true

    get 'Show a comment for a post' do
      tags 'Comments'
      produces 'application/json'
      response '200', 'show a comment for a post' do
        let(:user) { create(:user) }
        let(:post) { create(:post, user:) }
        let(:comment) { create(:comment, post:) }
        let(:user_id) { user.id }
        let(:post_id) { post.id }
        let(:id) { comment.id }
        run_test!
      end

      response '404', 'comment not found' do
        let(:user_id) { 0 }
        let(:post_id) { 0 }
        let(:id) { 0 }
        run_test!
      end
    end

    post 'Create a comment for a post' do
      tags 'Comments'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: ['text']
      }

      response '201', 'create a comment for a post' do
        let(:user)
        let(:post) { create(:post, user:) }
        let(:comment) { attributes_for(:comment, post:) }
        let(:user_id) { user.id }
        let(:post_id) { post.id }
        let(:comment) { { comment: } }
        run_test!
      end
    
      response '422', 'unprocessable entity' do
        let(:user) { create(:user) }
        let(:post) { create(:post, user:) }
        let(:comment) { attributes_for(:comment, post:, text: '') }
        let(:user_id) { user.id }
        let(:post_id) { post.id }
        let(:comment) { { comment: } }
        run_test!
      end
    end
    
    patch 'Update a comment for a post' do
      tags 'Comments'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: ['text']
      }
    
      response '200', 'update a comment for a post' do
        let(:user) { create(:user) }
        let(:post) { create(:post, user:) }
        let(:comment) { create(:comment, post:) }
        let(:user_id) { user.id }
        let(:post_id) { post.id }
        let(:id) { comment.id }
        let(:comment) { { comment: { text: 'Updated comment text' } } }
        run_test!
      end
    
      response '422', 'unprocessable entity' do
        let(:user) { create(:user) }
        let(:post) { create(:post, user:) }
        let(:comment) { create(:comment, post:) }
        let(:user_id) { user.id }
        let(:post_id) { post.id }
        let(:id) { comment.id }
        let(:comment) { { comment: { text: '' } } }
        run_test!
      end
    end
    
    delete 'Delete a comment for a post' do
      tags 'Comments'
      produces 'application/json'
      response '204', 'delete a comment for a post' do
        let(:user) { create(:user) }
        let(:post) { create(:post, user:) }
        let(:comment) { create(:comment, post:) }
        let(:user_id) { user.id }
        let(:post_id) { post.id }
        let(:id) { comment.id }
        run_test!
      end
    end
  end
