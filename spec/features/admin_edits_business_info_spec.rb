require "rails_helper"

feature "a seller/store admin can edit his business' info" do
  before do
    @seller = Seller.create(name: "ACME",
                            email: "hello@acme.com")

    @seller2 = Seller.create(name: "name",
                             email: "email@email.com")

    seller_admin = User.create(first_name: "John",
                               last_name: "Doe",
                               email: "email@example.com",
                               password: "password",
                               seller_id: @seller.id)

    Role.create(name: "seller_admin")

    seller_admin.roles << Role.find_by(name: "seller_admin")

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(seller_admin)
  end

  scenario "after logging in and with valid input" do
    visit seller_dashboard_path(@seller.slug)

    expect(current_path).to eq(seller_dashboard_path(@seller.slug))

    click_link "Edit Business Details"

    expect(current_path).to eq(edit_seller_seller_path(@seller.slug, @seller.id))

    fill_in "Name", with: "New Company Name"
    fill_in "Email", with: "newemail@newcompany.com"
    click_button "Edit Business"

    seller = Seller.find(@seller.id)
    expect(current_path).to eq(seller_dashboard_path(seller.slug))

    expect(page).to have_content("Your business information has been updated.")
    expect(seller.name).to eq("New Company Name")
    expect(seller.email).to eq("newemail@newcompany.com")
    expect(seller.slug).to eq("new-company-name")
  end

  scenario "after logging in with invalid input" do
    visit seller_dashboard_path(@seller.slug)

    expect(current_path).to eq(seller_dashboard_path(@seller.slug))

    click_link "Edit Business Details"

    expect(current_path).to eq(edit_seller_seller_path(@seller.slug, @seller.id))

    fill_in "Name", with: ""
    fill_in "Email", with: ""
    click_button "Edit Business"

    seller = Seller.find(@seller.id)
    expect(current_path).to eq(seller_dashboard_path(seller.slug))
    expect(page).to have_content("Name can't be blank. Email is invalid")

    visit seller_dashboard_path(@seller2.slug)
    expect(current_path).to eq(root_path)
  end
end
