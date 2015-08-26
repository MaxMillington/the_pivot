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
      password: "password")

    User.create!(
      first_name: "super",
      last_name: "admin",
      email: "super@turing.io",
      password: "password")
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
      name: "Video Games",
      description: Faker::Lorem.paragraph,
      image_url: 'pacman.jpg')
    Category.create!(
      name: "Instruments",
      description: Faker::Lorem.paragraph,
      image_url: 'nocaster.jpg')
    Category.create!(
      name: "Sports",
      description: Faker::Lorem.paragraph,
      image_url: 'MJ.jpg')
    Category.create!(
      name: "Toys",
      description: Faker::Lorem.paragraph,
      image_url: 'boba_fett.jpg')
    Category.create!(
      name: "Cars",
      description: Faker::Lorem.paragraph,
      image_url: 'model_e.jpg')
    Category.create!(
      name: "Comics",
      description: Faker::Lorem.paragraph,
      image_url: 'action_comics.jpg')
    Category.create!(
      name: "Books",
      description: Faker::Lorem.paragraph,
      image_url: 'bible.jpg')
    Category.create!(
      name: "Antiques",
      description: Faker::Lorem.paragraph,
      image_url: 'chippendale.jpg')
    Category.create!(
      name: "Entertainment",
      description: Faker::Lorem.paragraph,
      image_url: 'marilyn.jpg')
    Category.create!(
      name: "Guns",
      description: Faker::Lorem.paragraph,
      image_url: 'guns.jpg')
  end

  def generate_products


    Product.create(name: "Vintage Atari Gaming System",
                   description: "Take a trip back in time and kill some alien invaders and play some pong in this classic video game console ",
                   image_url: "atari.jpg",
                   category_id: 1,
                   condition: "good",
                   seller_id: Seller.all.sample.id)

    Product.create(name: "Vintage Gibson 1959 Les Paul",
                   description: "Purchasing this Holy Grail of electric guitars will put you in the same category as guitar legends like Jimmy Page and Michael Bloomfield.",
                   image_url: "les_paul.jpg",
                   category_id: 2,
                   condition: "excellent",
                   seller_id: Seller.all.sample.id)

    Product.create(name: "Singed Lawrence Taylor Jersey",
                   description: "Own the jersey of the most dangerous linebacker every to set foot on the field.",
                   image_url: "lt.jpeg",
                   category_id: 3,
                   condition: "mint",
                   seller_id: Seller.all.sample.id)

    Product.create(name: "AT-AT Set",
                   description: "Take down the rebellion on the icy planet of Hoth with this unique set of AT-AT walkers.",
                   image_url: "atat.jpg",
                   category_id: 4,
                   condition: "good",
                   seller_id: Seller.all.sample.id)

    Product.create(name: "Ferrari California",
                   description: "Drive off into the sunset in what is widely considered to be one of the most attractive automobiles ever made.",
                   image_url: "Ferrari_California.jpg",
                   category_id: 5,
                   condition: "mint",
                   seller_id: Seller.all.sample.id)

    Product.create(name: "Action Comics No. 1",
                   description: "Put off your retirment a few decades and purchase the first appearance of America's most beloved super hero.",
                   image_url: "action_comics.jpg",
                   category_id: 6,
                   condition: "mint",
                   seller_id: Seller.all.sample.id)

    Product.create(name: "First Edition Hobbit",
                   description: "Introduce yourself to Bilbo and Gandalf and their unexpected journey to Lonely Mountain.",
                   image_url: "hobbit.jpg",
                   category_id: 7,
                   condition: "poor",
                   seller_id: Seller.all.sample.id)

    Product.create(name: "1920's Tiffany Lamp",
                   description: "Own this gorgeous Tiffany lamp from the golden era of luxury.",
                   image_url: "tiffany.jpg",
                   category_id: 8,
                   condition: "mint",
                   seller_id: Seller.all.sample.id)

    Product.create(name: "Michael Jackson's Glove",
                   description: "Prove that Billy Jean is not your lover with Michael Jackson's one of a kind diamond studded glove.",
                   image_url: "glove.jpg",
                   category_id: 9,
                   condition: "mint",
                   seller_id: Seller.all.sample.id)

    Product.create(name: "Original Walker Colt",
                   description: "Go ahead, make someone's day with this highly sought after Spanish American War classic.",
                   image_url: "colt.jpg",
                   category_id: 10,
                   condition: "good",
                   seller_id: Seller.all.sample.id)


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
