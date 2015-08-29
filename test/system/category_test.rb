require_relative '../system_helper'

describe "Category Management" do
  include SystemHelper

  let(:category){ Fabricate :category }
  let(:role) { Fabricate :role, name: 'Admin' }
  let(:user)  { Fabricate(:user, 
    password: 'password', 
    password_confirmation: 'password', 
    fname: 'Paul', 
    lname: 'Williams', 
    email: 'apul@wbkdoi.com') do
      role { Fabricate(:role, name: 'Admin') }
    end
  }

  before do
    stub_user_session(user)
    # visit categories_path
    visit new_category_path
  end

  describe "Adding a category" do
    before do
      fill_in :category_name, with: "Pants"
      fill_in :category_description, with: "Dungarees, khakies, and more"
      click_button "Create Category"
    end

    it "should display a message when a new category is created" do
      assert has_content?("Category was successfully created")
      assert has_link?("Back")
    end

    it "should allow the user to go back to the category list" do
      find_link("Back").click
      assert has_content? "Listing Categories"
    end

    # describe "Managing a new idea" do

    #   before do
    #     find("#added-idea")
    #     find(".go-to-idea").click
    #   end

    #   it "allows ideas to be edited" do
    #     find(".edit-idea").click
    #     find(".new_idea")
    #     find("#edit-idea-name").set("Updated Idea Title")
    #     find(".update-idea").click
    #     title = find(".idea-title")
    #     assert title.has_content? "Updated Idea Title"
    #   end

    #   it "displays a confirmation modal when attempting to delete an idea" do
    #     find(".delete-idea").click
    #     assert has_content? "Are you you sure you want to delete the idea"
    #   end

    #   it "does not remove an idea if the user cancels the deletion modal" do
    #     find(".delete-idea").click
    #     within "#delete-idea" do
    #       find(".cancel-delete").click
    #     end
    #     assert has_content? "A New Idea"
    #   end

    #   it "deletes an idea" do
    #     find(".delete-idea").click
    #     within "#delete-idea" do
    #       find(".confirm-delete").click
    #     end
    #     refute has_content? "A New Idea"
    #   end

    #   it "should automatically add an upvote from the idea creator" do
    #     upvote = find(".upvote")
    #     count = upvote["count"]
    #     assert_equal "1", count
    #   end

    #   it "allows undoing idea upvote" do
    #     upvote = find(".upvote")
    #     upvote.click
    #     sleep(1) # Not ideal - but needed to ensure for the count data-attribute to get updated
    #     count = upvote["count"]
    #     assert_equal "0", count
    #   end

    #   describe "Commenting on an Idea" do

    #     before do
    #       within "#add-comment" do
    #         fill_in :comment_body, with: "Fantastic Idea!"
    #         click_button "Comment"
    #       end
    #     end

    #     it "should allow users to comment on ideas" do
    #       assert has_content? "1 Comment"
    #     end

    #     it "should allow commenters to delete their comment" do
    #       assert has_content? "1 Comment"
    #       find(".comment .delete-comment").click
    #       refute has_content? "1 Comments"
    #     end

    #     it "should allow commenters to edit their comment" do
    #       find(".comment .edit-comment").click
    #       find("#edit-comment")
    #       fill_in :edit_comment_body, with: "Updated Comment!"
    #       find(".save-updated-comment").click
    #       comment = find(".comment")
    #       assert comment.has_content? "Updated Comment!"
    #     end
    #   end
    # end
  end
end
