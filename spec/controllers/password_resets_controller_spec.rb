require 'spec_helper'

describe PasswordResetsController do

  let(:user) {FactoryGirl.create(:user)}

  describe "#create password reset token" do
    it "should " do
      user.stub(:send_password_reset) {}
      post 'create', :email => user.email
      user.should_receive(:send_password_reset)
    end
  end

end
