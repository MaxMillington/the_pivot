require "rails_helper"

feature "a visitor can create an account" do
  before do
    visit root_path
    click_link "Create Account"

    @seller = Seller.create(name: "ACME",
                            email: "hello@acme.com")

    @seller_admin = User.create(first_name: "John",
                                last_name: "Doe",
                                email: "email@example.com",
                                password: "password",
                                seller_id: @seller.id)

    Role.create(name: "platform_admin")
    Role.create(name: "seller_admin")
    Role.create(name: "registered_user")

    @platform_admin = User.create!(
        first_name: "platform",
        last_name: "admin",
        email: "super@turing.io",
        password: "password")

    @platform_admin.roles << Role.find_by(name: "platform_admin")

    @seller_admin.roles << Role.find_by(name: "seller_admin")
  end

  scenario "a visitor clicks on the create account button and" \
    " sees create account form" do
    expect(page).to have_content("First Name")
    expect(page).to have_content("Last Name")
    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
    expect(page).to have_button("Create Account")
  end

  scenario "a vistor fills out and submits a valid create account form and can then logout and log back in and see his profile and bids and stuff" do
    fill_in "First Name", with: nil
    fill_in "Last Name", with: nil
    fill_in "Email", with: "milesgo"
    fill_in "Password", with: "p"
    click_button "Create Account"

    expect(page).to have_content("Email is invalid")

    fill_in "First Name", with: "Miles"
    fill_in "Last Name", with: "Davis"
    fill_in "Email", with: "miles@turing.io"
    fill_in "Password", with: "password"
    click_button "Create Account"

    expect(current_path).to eq(profile_path)

    expect(page).to have_content("Miles")
    expect(page).to have_content("Davis")
    expect(page).to have_content("miles@turing.io")
    expect(page).to_not have_content("Login")
    expect(page).to have_content("Logout")

    click_link_or_button("Logout")
    expect(current_path).to eq(root_path)

    click_link_or_button("Login")
    fill_in "Email", with: "miles@turing.io"
    fill_in "Password", with: "password"
    click_button("Login")

    expect(current_path).to eq(profile_path)

    visit my_bids_path
    expect(current_path).to eq(my_bids_path)

    visit profile_path
    expect(current_path).to eq(profile_path)

    click_link_or_button("Edit Account")
    fill_in "First Name", with: "Monkey"
    fill_in "Last Name", with: "Sees"
    fill_in "Email", with: "monkey@turing.io"
    fill_in "Password", with: nil
    click_button "Update Login Info"

    expect(page).to have_content("Invalid password")

    fill_in "First Name", with: nil
    fill_in "Last Name", with: nil
    fill_in "Email", with: nil
    fill_in "Password", with: "password"
    click_button "Update Login Info"

    expect(page).to have_content("Email is invalid")

    fill_in "First Name", with: "Monkey"
    fill_in "Last Name", with: "Sees"
    fill_in "Email", with: "monkey@turing.io"
    fill_in "Password", with: "password"
    click_button "Update Login Info"

    expect(page).to have_content("Your account has been updated.")

    click_link_or_button("Logout")
    click_link_or_button("Login")

    fill_in "Email", with: "monkeymonkey@turing.io"
    fill_in "Password", with: "monkey"
    click_button("Login")

    expect(current_path).to eq(login_path)
  end

  scenario "a seller and platform admin can login and go to the right paths" do

    visit root_path

    click_link_or_button("Login")
    fill_in "Email", with: "email@example.com"
    fill_in "Password", with: "password"
    click_button("Login")

    expect(current_path).to eq("/acme/dashboard")
    click_link_or_button("Logout")

    click_link_or_button("Login")
    fill_in "Email", with: "super@turing.io"
    fill_in "Password", with: "password"
    click_button("Login")

    expect(current_path).to eq(platform_admin_dashboard_path)
  end

end
