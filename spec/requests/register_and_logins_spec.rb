require 'spec_helper'

describe "RegisterAndLogins" do

  describe "Login Page" do

    it "gets a login page" do
      visit '/'
      page.should have_content('Log In')
    end

  end

  describe "Register Page" do
    it "get user registration page" do
      visit '/register'
      page.should have_content('Sign Up')
    end
  end

end
