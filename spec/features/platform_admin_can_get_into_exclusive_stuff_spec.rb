require "rails_helper"

feature "Platform Admin can view Platform Admin Dashboard" do
  scenario "Platform Admin logs in and sees Platform Admin Dashboard" do
    @seller = Seller.create(name: "ACME",
                            email: "hello@acme.com")

    @seller = Seller.create(name: "Monkey INC",
                            email: "hello@monkey.com")

    platform_admin = User.create(first_name: "John",
                               last_name: "Doe",
                               email: "email@example.com",
                               password: "password",
                               seller_id: @seller.id)

    Role.create(name: "platform_admin")
    Role.create(name: "seller_admin")
    Role.create(name: "registered_user")

    platform_admin.roles << Role.find_by(name: "platform_admin")

    visit login_path

    fill_in "Email", with: "email@example.com"
    fill_in "Password", with: "password"
    click_button "Login"

    visit platform_admin_dashboard_path

    expect(current_path).to eq(platform_admin_dashboard_path)

    expect(page).to have_content("See All Products")
    expect(page).to have_content("See All Auctions")
    expect(page).to have_content("See All Users")
    expect(page).to have_content("See All Sellers")
  end
end
