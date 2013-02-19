require "spec_helper"

describe UserMailer do
  describe "password_reset" do
    let(:user) {FactoryGirl.create(:user)}
    let(:mail) {UserMailer.password_reset(user)}

    it "renders the headers" do
      mail.subject.should eq("Password Reset")
      mail.to.should eq([user.email])
      mail.from.should eq(["no_reply@mileage_tracker.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
