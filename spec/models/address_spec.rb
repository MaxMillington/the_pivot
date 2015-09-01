require "rails_helper"

RSpec.describe Address, type: :model do

    let(:user) do
    user = User.create!(first_name: "Jane",
                last_name:  "Doe",
                email:      "jane@doe.com",
                password:   "password")
    end

  let(:billing_address) do
    user.addresses.create!(
        type_of: 0,
        address_1: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state_abbr,
        zip_code: Faker::Address.zip_code.to_i,
        addressable_type: "User"
    )
  end

  let(:shipping_address) do
    user.addresses.create!(
        type_of: 1,
        address_1: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state_abbr,
        zip_code: Faker::Address.zip_code.to_i,
        addressable_type: "User"
    )
    end

  it "creates a billing address" do
    expect(billing_address.type_of).to eq("billing")
    expect(billing_address.address_1).to eq(billing_address.address_1)
    expect(billing_address.city).to eq(billing_address.city)
    expect(billing_address.state).to eq(billing_address.state)
    expect(billing_address.zip_code).to eq(billing_address.zip_code)
  end

  it "creates a shipping address" do
    expect(shipping_address.type_of).to eq("shipping")
    expect(shipping_address.address_1).to eq(shipping_address.address_1)
    expect(shipping_address.city).to eq(shipping_address.city)
    expect(shipping_address.state).to eq(shipping_address.state)
    expect(shipping_address.zip_code).to eq(shipping_address.zip_code)
  end

  it "belongs to a user" do
    expect(user.addresses.first.id).to eq(billing_address.id)
    expect(user.addresses.last.id).to eq(shipping_address.id)
  end

  it "has an address_1" do
    billing_address.address_1 = nil

    expect(billing_address).to_not be_valid
  end

  it "has a city" do
    billing_address.city = nil

    expect(billing_address).to_not be_valid
  end

  it "has a state" do
    billing_address.state = nil

    expect(billing_address).to_not be_valid
  end

  it "has a zip_code" do
    billing_address.zip_code = nil

    expect(billing_address).to_not be_valid
  end

  it "has a numeric zip_code" do
    billing_address.zip_code = "abcde"

    expect(billing_address).to_not be_valid
  end

  it "has a zip_code length of 5-9" do
    billing_address.zip_code = 1234
    expect(billing_address).to_not be_valid

    billing_address.zip_code = 1234567890
    expect(billing_address).to_not be_valid

    billing_address.zip_code = 12345
    expect(billing_address).to be_valid

    billing_address.zip_code = 123456789
    expect(billing_address).to be_valid
  end

  it "strips whitespace for all text columns" do
    address = Address.create(address_1: " Address 1 ",
                             address_2: " Address 2 ",
                             city:      " City ",
                             state:     " ST ",
                             zip_code:  " 12345 ")

    expect(address.address_1).to eq("Address 1")
    expect(address.address_2).to eq("Address 2")
    expect(address.city).to eq("City")
    expect(address.state).to eq("ST")
    expect(address.zip_code).to eq("12345")
  end
end
