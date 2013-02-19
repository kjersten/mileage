require 'spec_helper'

describe User do
  
  describe "#send_password_reset" do

    let(:user) {FactoryGirl.create(:user)}

    it "initially, password reset fields should be blank" do
      user.password_reset_token.should be_nil
      user.password_reset_sent_at.should be_nil
    end

    it "should update password reset fields" do
      user.send_password_reset
      user.password_reset_token.should_not be_nil
      user.password_reset_sent_at.should > 1.minutes.ago
    end

  end


end