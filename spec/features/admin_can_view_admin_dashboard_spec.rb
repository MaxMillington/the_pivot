require "rails_helper"

feature "Admin can view Admin Dashboard" do
  scenario "Admin logs in and sees Admin Dashboard for /admin/dashboard" do
    @seller = Seller.create(name: "ACME",
                            email: "hello@acme.com")

    seller_admin = User.create(first_name: "John",
                               last_name: "Doe",
                               email: "email@example.com",
                               password: "password",
                               seller_id: @seller.id)

    Role.create(name: "platform_admin")
    Role.create(name: "seller_admin")
    Role.create(name: "registered_user")

    seller_admin.roles << Role.find_by(name: "seller_admin")

    visit login_path

    fill_in "Email", with: "email@example.com"
    fill_in "Password", with: "password"
    click_button "Login"

    visit seller_dashboard_path(@seller.slug)

    expect(current_path).to eq("/acme/dashboard")
  end

  scenario "Non-admin logs in and can't see admin dashboard" do
    @seller = Seller.create(name: "ACME",
                            email: "hello@acme.com")

    regular_user = User.create(first_name: "John",
                               last_name: "Doe",
                               email: "monkey@example.com",
                               password: "password")

    Role.create(name: "platform_admin")
    Role.create(name: "seller_admin")
    Role.create(name: "registered_user")

    visit login_path

    fill_in "Email", with: "monkey@example.com"
    fill_in "Password", with: "password"
    click_button "Login"

    visit seller_dashboard_path(@seller.slug)

    expect(current_path).to eq(root_path)
  end

  scenario "Non-user cant see admin dashboard" do
    @seller = Seller.create(name: "ACME",
                            email: "hello@acme.com")

    visit seller_dashboard_path(@seller.slug)

    expect(current_path).to eq(root_path)
  end
end
