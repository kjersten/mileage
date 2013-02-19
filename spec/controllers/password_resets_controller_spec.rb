require 'spec_helper'

describe PasswordResetsController do

  let(:user) {FactoryGirl.create(:user)}

  describe "POST create" do
    before(:each) do
      post :create, :email => user.email
    end

    it "should set a new password_reset_token" do
      upd_usr = User.find_by_email user.email
      upd_usr.password_reset_token.should_not be_nil
    end

    it "should redirect with a notice" do
      response.should redirect_to(login_path)
      flash[:notice].should_not be_nil
    end
  end

end
