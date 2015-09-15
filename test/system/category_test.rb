require_relative '../system_helper'

describe "Category Management" do
  include SystemHelper

  let(:category){ Fabricate :category }
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
    visit new_category_path

    fill_in :category_name, with: "Pants"
    fill_in :category_description, with: "Dungarees, khakies, and more"
    click_button "Create Category"

  end

  describe "Adding a category" do
    # before do
    #   fill_in :category_name, with: "Pants"
    #   fill_in :category_description, with: "Dungarees, khakies, and more"
    #   click_button "Create Category"
    # end

    it "should display a message when a new category is created" do
      assert has_content?("Category was successfully created")
      assert has_link?("Back")
    end

    it "should allow the user to go back to the category list" do
      find_link("Back").click
      assert has_content? "Listing Categories"
    end

  end

  describe "Editing a category" do     
    it "allows categories to be edited" do
      find_link("Edit").click
      fill_in :category_name, with: "Pants, Shorts and Skirts"
      click_button "Update Category"
      assert has_content?("Category was successfully updated")
    end
  end

  describe "Deleting a category" do 
    # before do
    #   visit new_category_path
    #   fill_in :category_name, with: "Pants"
    #   fill_in :category_description, with: "Dungarees, khakies, and more"
    #   click_button "Create Category"
    # end

    it "allows a category to be deleted" do
      visit categories_path

      # find_link("Destroy").click
      # a = page.driver.browser.switch_to.alert.accept
      # # page.driver.switchTo().alert().accept();
      # assert has_content?("Category was successfully destroyed")
    end
  end
end
