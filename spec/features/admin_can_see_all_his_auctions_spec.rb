require "rails_helper"

feature "seller/store admin can see all his store's auctions" do
  before do
    @seller = Seller.create(name: "ACME",
                            email: "hello@acme.com")

    @seller2 = Seller.create(name: "AWESOME CO.",
                             email: "hello@awesome.com")

    category = Category.create(name: "Comics")
    category2 = Category.create(name: "Instruments")

    @product = @seller.products.create(name: "The Amazing Spider-Man",
                                       category_id: category.id,
                                       description: "The description goes here",
                                       condition: "mint")

    @product2 = @seller2.products.create(name: "Gibson Les Paul",
                                         category_id: category2.id,
                                         description: "Guitar",
                                         condition: "mint")

    @seller_admin = User.create(first_name: "John",
                                last_name: "Doe",
                                email: "email@example.com",
                                password: "password",
                                seller_id: @seller.id)

    User.create(first_name: "John",
                last_name: "Doe",
                email: "email@example.com",
                password: "password",
                seller_id: @seller.id)


    Auction.create(product_id: @product.id,
                   starting_time: DateTime.now,
                   ending_time: DateTime.now + 2.days,
                   starting_price: 500)

    Auction.create(product_id: @product2.id,
                   starting_time: DateTime.now,
                   ending_time: DateTime.now + 2.days,
                   starting_price: 600)


    Role.create(name: "seller_admin")

    @seller_admin.roles << Role.find_by(name: "seller_admin")

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(@seller_admin)
  end

  scenario "when logged in he should only see his auctions" do
    visit seller_dashboard_path(@seller.slug)

    expect(current_path).to eq(seller_dashboard_path(@seller.slug))

    click_link("View All Auctions")

    expect(current_path).to eq(seller_auctions_path(@seller.slug))

    expect(page).to have_content("The Amazing Spider-Man")
    expect(page).to have_content("Comics")

    expect(page).to_not have_content("Gibson Les Paul")
  end
end 
