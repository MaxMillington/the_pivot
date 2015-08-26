class Seed
  def self.start
    seed = Seed.new
    seed.generate_users
    seed.generate_sellers
    seed.generate_addresses
    seed.generate_categories
    seed.generate_products
    seed.generate_roles
  end

  def generate_users
    100.times do |i|
      user = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: Faker::Internet.password 
      )
    end

    User.create!(
      first_name: "Jorge",
      last_name: "Tellez",
      email: "jorge@turing.io",
      password: "password")

    User.create!(
      first_name: "business",
      last_name: "admin",
      email: "admin@turing.io",
      password: "password",
      role: 1)

    User.create!(
      first_name: "super",
      last_name: "admin",
      email: "super@turing.io",
      password: "password",
      role: 2)
  end

  def generate_sellers
    20.times do |i|
      Seller.create!(
        name: Faker::Company.name, 
        email: Faker::Internet.email)
    end
  end

  def generate_addresses
    1.upto(100) do |i|
      Address.create!(
        type_of: 0,
        address_1: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state_abbr,
        zip_code: Faker::Address.zip_code.to_i,
        addressable_type: "User",
        addressable_id: i 
      )
    end

    1.upto(20) do |i|
      Address.create!(
        type_of: 0, 
        address_1: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state_abbr,
        zip_code: Faker::Address.zip_code.to_i,
        addressable_type: "Seller",
        addressable_id: i
      )
    end

  end

  def generate_categories
    Category.create!(
      name: "Games",
      description: Faker::Lorem.paragraph)
    Category.create!(
      name: "Instruments",
      description: Faker::Lorem.paragraph)
    Category.create!(
      name: "Sports",
      description: Faker::Lorem.paragraph)
    Category.create!(
      name: "Toys",
      description: Faker::Lorem.paragraph)
    Category.create!(
      name: "Cars",
      description: Faker::Lorem.paragraph)
    Category.create!(
      name: "Animals",
      description: Faker::Lorem.paragraph)
    Category.create!(
      name: "Books",
      description: Faker::Lorem.paragraph)
    Category.create!(
      name: "Antiques",
      description: Faker::Lorem.paragraph)
    Category.create!(
      name: "Entertainment",
      description: Faker::Lorem.paragraph)
    Category.create!(
      name: "Guns",
      description: Faker::Lorem.paragraph)
  end

  def generate_products
    Category.all.each do |category|
      50.times do |i|
        product = Product.create!(
          name: Faker::Commerce.product_name,
          description: Faker::Lorem.paragraph,
          image_url: Faker::Avatar.image,
          category_id: category.id,
          condition: ["fair", "good", "poor", "mint", "excellent"].sample,
          seller_id: Seller.all.sample.id)
      end
    end
  end

  def generate_roles
    Role.create!(name: "platform_admin")
    Role.create!(name: "seller_admin")
    Role.create!(name: "registered_user")
  end

end
Seed.start
