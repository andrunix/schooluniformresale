require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  setup do
    @message = messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create message" do
    assert_difference('Message.count') do
      post :create, message: { folder_id: @message.folder_id, from_user_id: @message.from_user_id, item_id: @message.item_id, message: @message.message, parent_message_id: @message.parent_message_id, subject: @message.subject, to_user_id: @message.to_user_id, unread: @message.unread }
    end

    assert_redirected_to message_path(assigns(:message))
  end

  test "should show message" do
    get :show, id: @message
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @message
    assert_response :success
  end

  test "should update message" do
    patch :update, id: @message, message: { folder_id: @message.folder_id, from_user_id: @message.from_user_id, item_id: @message.item_id, message: @message.message, parent_message_id: @message.parent_message_id, subject: @message.subject, to_user_id: @message.to_user_id, unread: @message.unread }
    assert_redirected_to message_path(assigns(:message))
  end

  test "should destroy message" do
    assert_difference('Message.count', -1) do
      delete :destroy, id: @message
    end

    assert_redirected_to messages_path
  end
end
