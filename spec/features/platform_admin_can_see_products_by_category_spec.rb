require "rails_helper"

feature "anyone can view auctions by category" do
  before do
    @seller = Seller.create(name: "ACME",
                            email: "hello@acme.com")

    category = Category.create(name: "Comics")
    category2 = Category.create(name: "Instruments")

    @product = @seller.products.create(name: "The Amazing Spider-Man",
                                       category_id: category.id,
                                       description: "The description goes here",
                                       condition: "mint")

    @product2 = @seller.products.create(name: "Gibson Les Paul",
                                        category_id: category2.id,
                                        description: "Guitar",
                                        condition: "mint")

    @seller_admin = User.create(first_name: "John",
                                last_name: "Doe",
                                email: "email@example.com",
                                password: "password",
                                seller_id: @seller.id)

    @regular_user = User.create(first_name: "Miles",
                                last_name: "Davis",
                                password: "password")

    auction_1 = Auction.create(product_id: @product.id,
                               starting_time: DateTime.now,
                               ending_time: DateTime.now + 2.days,
                               starting_price: 500,
                               category_id: category.id)

    auction_2 = Auction.create(product_id: @product2.id,
                               starting_time: DateTime.now,
                               ending_time: DateTime.now + 2.days,
                               starting_price: 600,
                               category_id: category2.id)

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

  context "visits /categories" do

    scenario "sees list of categories and get see auctions by category" do
      allow_any_instance_of(ApplicationController)
          .to receive(:current_user).and_return(@platform_admin)

      visit products_path

      expect(current_path).to eq(products_path)

      expect(page).to have_content("Gibson Les Paul")

      expect(page).to have_content("Instruments")

      within(".list-group", text: "Instruments") do
        click_link_or_button("Instruments")
      end

      expect(page).to have_content("Gibson Les Paul")

      within(".list-group", text: "Comics") do
        click_link_or_button("Comics")
      end

      expect(page).to have_content("The Amazing Spider-Man")
    end
  end

end
