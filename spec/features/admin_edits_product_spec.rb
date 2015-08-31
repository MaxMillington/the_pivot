require 'rails_helper'

feature "seller/store admin edits a product" do
  before do
    @seller = Seller.create(name: "ACME",
                            email: "hello@acme.com")

    category = Category.create(name: "Comics")
    category = Category.create(name: "Instruments")

    @product = @seller.products.create(name: "The Amazing Spider-Man",
                                       category_id: category.id,
                                       description: "The description goes here",
                                       condition: "mint")

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

    click_link "edit"

    fill_in "Name", with: "The Amazing Superman"
    fill_in "Description", with: "This is the new description"
    fill_in "Condition", with: "pristine"
    select "Instruments", from: "product[category_id]"
    fill_in "Image Url", with: "other_url"
    click_button "Edit Product"

    within(".alert-success") do
      expect(page).to have_content("You successfully edited The Amazing Superman.") 

    end

    expect(current_path).to eq(seller_product_path(@seller.slug, @product.id))

    expect(page).to have_content("The Amazing Superman")
    expect(page).to have_content("This is the new description")
    expect(page).to have_content("pristine")
    expect(page).to have_content("Instruments")
    expect(page).to have_css("img[src*='other_url']")
  end
end
