require "rails_helper"

feature "permissions_test" do
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

  context "guest user can only view certain paths" do

    scenario "guest user can view his permissions" do

      visit root_path

      expect(current_path).to eq(root_path)

      click_link_or_button("Create Account")

      expect(current_path).to eq(profile_new_path)

      click_link_or_button("Sellers")

      expect(current_path).to eq(sellers_path)

      click_link_or_button("View Auctions")

      expect(current_path).to eq(seller_path(@seller))

      visit categories_path

      expect(current_path).to eq(categories_path)

    end

    scenario "guest user can't what he doesn't have permission for" do
      visit products_path

      expect(current_path).to eq(root_path)

    end
  end

  #
  # context "registered user can only view certain paths" do
  #
  #   scenario "registered user can view his permissions" do
  #     allow_any_instance_of(ApplicationController)
  #         .to receive(:current_user).and_return(@regular_user)
  #     visit products_path
  #
  #     expect(current_path).to eq(products_path)
  #
  #     expect(page).to have_content("Gibson Les Paul")
  #
  #     expect(page).to have_content("Instruments")
  #
  #     within(".list-group", text: "Instruments") do
  #       click_link_or_button("Instruments")
  #     end
  #
  #     expect(page).to have_content("Gibson Les Paul")
  #
  #     within(".list-group", text: "Comics") do
  #       click_link_or_button("Comics")
  #     end
  #
  #     expect(page).to have_content("The Amazing Spider-Man")
  #   end
  #
  #   scenario "registered user can't view what he doesn't have permission for" do
  #     allow_any_instance_of(ApplicationController)
  #         .to receive(:current_user).and_return(@regular_user)
  #
  #     visit products_path
  #
  #     expect(current_path).to eq(products_path)
  #
  #     expect(page).to have_content("Gibson Les Paul")
  #
  #     expect(page).to have_content("Instruments")
  #
  #     within(".list-group", text: "Instruments") do
  #       click_link_or_button("Instruments")
  #     end
  #
  #     expect(page).to have_content("Gibson Les Paul")
  #
  #     within(".list-group", text: "Comics") do
  #       click_link_or_button("Comics")
  #     end
  #
  #     expect(page).to have_content("The Amazing Spider-Man")
  #   end
  # end
  #
  # context "seller admin can only view certain paths" do
  #
  #   scenario "seller admin can view his permissions" do
  #     allow_any_instance_of(ApplicationController)
  #         .to receive(:current_user).and_return(@seller_admin)
  #
  #     visit products_path
  #
  #     expect(current_path).to eq(products_path)
  #
  #     expect(page).to have_content("Gibson Les Paul")
  #
  #     expect(page).to have_content("Instruments")
  #
  #     within(".list-group", text: "Instruments") do
  #       click_link_or_button("Instruments")
  #     end
  #
  #     expect(page).to have_content("Gibson Les Paul")
  #
  #     within(".list-group", text: "Comics") do
  #       click_link_or_button("Comics")
  #     end
  #
  #     expect(page).to have_content("The Amazing Spider-Man")
  #   end
  #
  #   scenario "seller admin can't view what he doesn't have permission for" do
  #     allow_any_instance_of(ApplicationController)
  #         .to receive(:current_user).and_return(@seller_admin)
  #
  #     visit products_path
  #
  #     expect(current_path).to eq(products_path)
  #
  #     expect(page).to have_content("Gibson Les Paul")
  #
  #     expect(page).to have_content("Instruments")
  #
  #     within(".list-group", text: "Instruments") do
  #       click_link_or_button("Instruments")
  #     end
  #
  #     expect(page).to have_content("Gibson Les Paul")
  #
  #     within(".list-group", text: "Comics") do
  #       click_link_or_button("Comics")
  #     end
  #
  #     expect(page).to have_content("The Amazing Spider-Man")
  #   end
  # end
  #
  # context "platform admin can see all" do
  #
  #   scenario "registered user can view his permissions" do
  #     allow_any_instance_of(ApplicationController)
  #         .to receive(:current_user).and_return(@platform_admin)
  #     visit products_path
  #
  #     expect(current_path).to eq(products_path)
  #
  #     expect(page).to have_content("Gibson Les Paul")
  #
  #     expect(page).to have_content("Instruments")
  #
  #     within(".list-group", text: "Instruments") do
  #       click_link_or_button("Instruments")
  #     end
  #
  #     expect(page).to have_content("Gibson Les Paul")
  #
  #     within(".list-group", text: "Comics") do
  #       click_link_or_button("Comics")
  #     end
  #
  #     expect(page).to have_content("The Amazing Spider-Man")
  #   end
  # end

end
