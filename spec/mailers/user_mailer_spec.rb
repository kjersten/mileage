require "spec_helper"

describe UserMailer do

  # before(:each) {
  #   @user = FactoryGirl.create(:user, pw_reset: true)
  #   @mail = UserMailer.password_reset(@user)
  # }
  
  let(:user) {FactoryGirl.create(:user, pw_reset: true)}
  let(:mail) {UserMailer.password_reset(user)}

  it "renders the headers" do
    mail.subject.should eq("Password Reset")
    mail.to.should eq([user.email])
    mail.from.should eq(["no_reply@mileage_tracker.com"])
  end

end
