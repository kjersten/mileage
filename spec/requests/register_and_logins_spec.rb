require 'spec_helper'

describe "Login and Registration:" do

  subject { page }

  describe "Registration:" do
    fixtures :users
    before { visit register_path }
    it { should  have_selector('h1', text: 'Sign Up') }

    # no user name
    it "gives an error if I register without a user name" do
      fill_in 'user[email]', :with => 'user@test.com'
      fill_in 'user[password]', :with => 'test'
      fill_in 'user[password_confirmation]', :with => 'test'
      click_button 'Register'
      page.should have_selector '#error_explanation'
      page.should have_selector 'li', :text => "Name is required"
    end

    # no email
    it "gives an error if I register without an email" do
      fill_in 'user[name]', :with => 'Test User'
      fill_in 'user[password]', :with => 'test'
      fill_in 'user[password_confirmation]', :with => 'test'
      click_button 'Register'
      page.should have_selector '#error_explanation'
      page.should have_selector 'li', :text => "Email is required"
    end

    # invalid email address
    it "gives an error if I register with an invalid email address" do
      fill_in 'user[name]', :with => 'Test User'
      fill_in 'user[email]', :with => 'test'
      fill_in 'user[password]', :with => 'test'
      fill_in 'user[password_confirmation]', :with => 'test'
      click_button 'Register'
      page.should have_selector '#error_explanation'
      page.should have_selector 'li', :text => "Email is invalid"
    end

    # no password or password confirmation
    it "gives an error if I register without a password" do
      fill_in 'user[email]', :with => 'user@test.com'
      fill_in 'user[name]', :with => 'Test User'
      click_button 'Register'
      page.should have_selector '#error_explanation'
      page.should have_selector 'li', :text => "Password is required"
      page.should have_selector 'li', :text => "Password confirmation is required"
    end

    # password too short
    it "gives an error if I register with a short password" do
      fill_in 'user[email]', :with => 'user@test.com'
      fill_in 'user[name]', :with => 'Test User'
      fill_in 'user[password]', :with => 'abc'
      fill_in 'user[password_confirmation]', :with => 'abc'
      click_button 'Register'
      page.should have_selector '#error_explanation'
      page.should have_selector 'li', :text => "Password must be at least 4 characters"
    end

    # password too long
    it "gives an error if I register with a long password" do
      fill_in 'user[email]', :with => 'user@test.com'
      fill_in 'user[name]', :with => 'Test User'
      fill_in 'user[password]', :with => '123456789012345678901'
      fill_in 'user[password_confirmation]', :with => '123456789012345678901'
      click_button 'Register'
      page.should have_selector '#error_explanation'
      page.should have_selector 'li', :text => "Password cannot be longer than 20 characters"
    end

    # password and password confirmation don't match
    it "gives an error if the password and password confirmation don't match" do
      fill_in 'user[email]', :with => 'user@test.com'
      fill_in 'user[name]', :with => 'Test User'
      fill_in 'user[password]', :with => 'test'
      fill_in 'user[password_confirmation]', :with => 'no_match'
      click_button 'Register'
      page.should have_selector '#error_explanation'
      page.should have_selector 'li', :text => "Password doesn't match confirmation"
    end

    # duplicate user
    it "gives an error if you try to register with the same email twice" do
      fill_in 'user[name]', :with => 'User with Duplicate Email'
      fill_in 'user[email]', :with => 'already_here@test.com'
      fill_in 'user[password]', :with => 'test'
      fill_in 'user[password_confirmation]', :with => 'test'
      click_button 'Register'
      page.should have_selector '#error_explanation'
      page.should have_selector 'li', :text => "Email has already been taken"
    end

    # successful registration
    it "registers a new account for me" do
      fill_in 'user[name]', :with => 'Test User'
      fill_in 'user[email]', :with => 'user@test.com'
      fill_in 'user[password]', :with => 'test'
      fill_in 'user[password_confirmation]', :with => 'test'
      click_button 'Register'
      page.should have_selector '#notice', :text => 'Your account has been created!'
    end

  end

  describe "Login Page:" do
    fixtures :users
    before { visit root_path }
    it { should have_selector 'h1', :text => 'Log In' }

    # successful login
    it "logs me in when I have an existing account" do
      fill_in 'email', :with => 'test@test.com'
      fill_in 'password', :with => 'test'
      click_button 'Log in'
      page.should have_selector '#notice', :text => 'Logged in!'
      page.should have_link 'Log out'
      click_link 'Log out'
      page.should have_selector 'h1', :text => 'Log In'
    end

    # valid user, invalid password
    it "logs me in when I have an existing account" do
      fill_in 'email', :with => 'francine@test.com'
      fill_in 'password', :with => 'test'
      click_button 'Log in'
      page.should have_selector '#error_explanation'
      page.should have_selector 'h2', :text => "Invalid email or password"
    end

    # user not found
    it "logs me in when I have an existing account" do
      fill_in 'email', :with => 'test@test.com'
      fill_in 'password', :with => 'abcdefgh'
      click_button 'Log in'
      page.should have_selector '#error_explanation'
      page.should have_selector 'h2', :text => "Invalid email or password"
    end

  end

end
