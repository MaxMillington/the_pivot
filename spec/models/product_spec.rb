require "rails_helper"

RSpec.describe Product, type: :model do
  before do
    @seller = Seller.create(
        name: "IBM Inc.",
        email: "home@ibm.com"
    )

    @category = Category.create(
        name: "Electronics",
        description: "Gadgets galore!"
    )

    @product = Product.create(
        category_id: @category.id,
        name: "Computer",
        description: "This computer is really fast!",
        condition: "good",
        seller_id:  @seller.id,
    )
  end

  it "is created and belongs to a category" do
    expect(@product.name).to eq("Computer")
    expect(@product.description).to eq(
      "This computer is really fast!")
    expect(@product.seller.name).to eq("IBM Inc.")

    expect(@product.category.name).to eq("Electronics")
    expect(@product.category.description).to eq(
      "Gadgets galore!")
  end

  it "requires a name" do
    @product.name = nil
    expect(@product).to_not be_valid
  end

  it "requires a unique name" do
    product2 = @category.products.create(
      name: "Computer",
      description: "Another Computer!",)

    expect(product2).to_not be_valid
  end

  it "requires a description" do
    @product.description = nil

    expect(@product).to_not be_valid
  end


  it "requires a category" do
    no_category_product = Product.create(
      name: "Venus Fly Trap",
      description: "The gold standard of carnivorous plants!")

    expect(no_category_product).to_not be_valid
  end
end
