require_relative '../system_helper'

describe "School Management" do
  include SystemHelper

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
    visit schools_path
    click_link "New School"
  end

  describe "Adding a school" do
    before do
      fill_in :school_name, with: "Test School"
      fill_in :school_description, with: "A nice school"
      fill_in :school_address1, with: "123 Main st"
      fill_in :school_address2, with: "blah"
      fill_in :school_city, with: "Chattanooga"
      fill_in :school_state, with: "TN"
      fill_in :school_zip, with: "33333"
      fill_in :school_url, with: "http://www.schooluniformresale.com"
      fill_in :school_email, with: "hello@sur.com"
      click_button "Save School"
    end

    it "should display a message when a new school is created" do
      assert has_content?("School was successfully created")
      assert has_link?("Schools list")
    end

    it "should allow the user to go back to the schools list" do
      click_link("Schools list")
      assert has_content? "Listing Schools"
    end
    
    it "allows schools to be edited" do
      visit schools_path
      click_link "edit"

      fill_in :school_name, with: "Updated School"
      click_button "Save School"
      assert has_content?("School was successfully updated")
    end

    # it "allows a school to be deleted" do
    #   visit schools_path 
    #   click_link "delete"
    #   a = page.driver.browser.switch_to.alert.accept
    #   assert has_content?("School was successfully destroyed")
    # end
  end
end
