require "rails_helper"

feature "a seller/store admin can create products" do
  before do
    @seller = Seller.create(name: "ACME",
                            email: "hello@acme.com")

    Category.create(name: "Cars")
    category = Category.create(name: "Comics")

   
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

    click_link "View All Products"

    expect(current_path).to eq(seller_products_path(@seller.slug))

    click_link "Add New Product"

    expect(current_path).to eq(new_seller_product_path(@seller.slug))

    fill_in "Name", with: "The Amazing Spider-Man"
    fill_in "Description", with: "This is the description."
    fill_in "Condition", with: "Mint"
    select "Comics", from: "product[category_id]"
    fill_in "Image Url", with: "image_url"
    click_button "Add Product"

    within(".alert-success") do
      expect(page).to have_content("The Amazing Spider-Man has been added.")
    end
    expect(current_path).to eq(seller_dashboard_path(@seller.slug))
    expect(Product.count).to eq(1)

    visit seller_products_path(@seller.slug)
    
    expect(page).to have_content("The Amazing Spider-Man")
  end
 end
