require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  scenario "User receives email when account created" do

    @user = User.create(first_name: "Bob", last_name: "Jones", email: "alex.tideman@gmail.com",
                        password: "password")
    mail = UserMailer.account_creation(@user)
    assert_equal "Welcome to Collector's World Bob Jones!", mail.subject
    assert_equal ["alex.tideman@gmail.com"], mail.to
    assert_equal ["hello@collectorsworld.com"], mail.from
    assert_match "Thanks", mail.body.encoded
  end
end
