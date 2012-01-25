require 'spec_helper'

describe "the login process" do

  subject { page }

  describe "Login Page" do
    before { visit root_path }
    it { should have_selector('h1', text: 'Log In') }
  end

  describe "Registration Page" do
    before { visit register_path }

    it { should  have_selector('h1', text: 'Sign Up') }
  end

end
