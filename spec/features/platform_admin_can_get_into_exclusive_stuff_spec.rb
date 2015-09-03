require "rails_helper"

feature "Platform Admin can view Platform Admin Dashboard" do
  scenario "Platform Admin logs in and sees Platform Admin Dashboard and can click links to get into exclusive stuff" do
    @seller = Seller.create(name: "ACME",
                            email: "hello@acme.com")

    @seller = Seller.create(name: "Monkey INC",
                            email: "hello@monkey.com")

    platform_admin = User.create(first_name: "John",
                               last_name: "Doe",
                               email: "email@example.com",
                               password: "password",
                               seller_id: @seller.id)

    @regular_user = User.create(first_name: "Steve",
                last_name: "McQueen",
                email: "monkey@steve.com",
                password: "password")

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

    expect(page).to have_content("View All Products")
    expect(page).to have_content("View All Auctions")
    expect(page).to have_content("View All Users")
    expect(page).to have_content("Create A Seller")

    click_link("View All Products")
    expect(current_path).to eq(products_path)

    within ('.navbar') do
    click_link("Platform Admin Dashboard")
    end

    expect(current_path).to eq(platform_admin_dashboard_path)

    click_link("View All Auctions")
    expect(current_path).to eq(auctions_path)

    click_link("Platform Admin Dashboard")

    click_link("View All Users")
    expect(current_path).to eq(platform_admin_users_path)
    expect(page).to have_content("Steve McQueen")

    click_link("Platform Admin Dashboard")
    click_link("Create A Seller")
    expect(current_path).to eq(new_platform_admin_seller_path)
    expect(page).to have_content("Create")

    fill_in "Name", with: nil
    fill_in "Email", with: nil
    expect(current_path).to eq(new_platform_admin_seller_path)

    fill_in "Name", with: "Chuck's Roast"
    fill_in "Email", with: "chuck@email.com"
    click_link_or_button("Create")
    expect(page).to have_content("Successfully created new seller.")

    click_link("Platform Admin Dashboard")
    click_link("Create Seller Admin")
    expect(current_path).to eq(new_platform_admin_user_path)


    fill_in "First Name", with: "Steve"
    fill_in "Last Name", with: "Jones"
    fill_in "Email", with: "jones@example.com"
    select "ACME", from: "user[seller_id]"
    fill_in "Password", with: "password"
    click_button "Create Seller Admin"

    expect(page).to have_content("Successfully Created Seller Admin, Steve Jones")

    click_link "Logout"

    visit login_path

    fill_in "Email", with: "email@example.com"
    fill_in "Password", with: "password"
    click_button "Login"

    click_link "Sellers"
    expect(current_path).to eq(sellers_path)

  end

  scenario "Platform Admin logs in and sees Platform Admin Dashboard and can click links to get into exclusive stuff" do
    @seller = Seller.create(name: "ACME",
                            email: "hello@acme.com")

    platform_admin = User.create(first_name: "John",
                                 last_name: "Doe",
                                 email: "email@example.com",
                                 password: "password")

    @regular_user = User.create(first_name: "Steve",
                                last_name: "McQueen",
                                email: "monkey@steve.com",
                                password: "password")

    @category = Category.create!(
        name: "Video Games",
        description: Faker::Lorem.paragraph,
        image_url: 'pacman.jpg')

    @product = Product.create(name: "Vintage Atari Gaming System",
                              description: "Take a trip back in time and kill some alien invaders and play some pong in this classic video game console ",
                              image_url: "video_games/atari.jpg",
                              category_id: @category.id,
                              condition: "good",
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

    click_link_or_button "View All Products"
    
    click_link_or_button "Edit"
    expect(page).to have_content("Edit Product")

    click_link "Sellers"
    expect(current_path).to eq(sellers_path)

    click_link "Delete Seller"
    expect(page).to have_content("Successfully deleted seller.")

  end
end
