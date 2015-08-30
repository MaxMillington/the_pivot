require 'rails_helper'

feature "seller admin creates an auction" do
  before do
    @seller = Seller.create(name: "ACME",
                           email: "hello@acme.com")

    category = Category.create(name: "Comics")

    @product = @seller.products.create(name: "The Amazing Spider-Man",
                                       category_id: category.id,
                                       description: "The description goes here",
                                       condition: "mint")

    seller_admin = User.create(first_name: "John",
                               last_name: "Doe",
                               email: "email@example.com",
                               password: "password",
                               seller_id: @seller.id)

    Role.create(name: "platform_admin")
    Role.create(name: "seller_admin")
    Role.create(name: "registered_user")

    seller_admin.roles << Role.find_by(name: "seller_admin")

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(seller_admin)
  end

  scenario "after logging in and with valid input" do
    visit seller_product_path(@seller.slug, @product)
    
    expect(current_path).to eq(seller_product_path(@seller.slug, @product))

    click_link "Create Auction"

    expect(current_path).to eq(new_seller_auction_path(@seller.slug))

    fill_in "Starting price", with: "10.00"
    select "2015",   from: "starting_time[year]"
    select "August", from: "starting_time[month]"
    select "29",     from: "starting_time[day]"
    select "06 PM",  from: "starting_time[hour]"
    select "15",     from: "starting_time[minute]"
    select "2015",   from: "ending_time[year]"
    select "August", from: "ending_time[month]"
    select "29",     from: "ending_time[day]"
    select "06 PM",  from: "ending_time[hour]"
    select "15",     from: "ending_time[minute]"
    click_button "Add Auction"

    within(".alert-success") do
      expect(page).to have_content("Your new auction has been scheduled.")
    end 

    expect(current_path).to eq(seller_dashboard_path(@seller.slug))

    expect(Auction.count).to eq(1)
  end
end
