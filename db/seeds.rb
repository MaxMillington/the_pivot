class Seed
  def self.start
    seed = Seed.new
    seed.generate_roles
    seed.generate_sellers
    seed.generate_users
    seed.generate_addresses
    seed.generate_categories
    seed.generate_products
    seed.generate_auctions
    seed.generate_bids
  end

  def generate_roles
    Role.create!(name: "platform_admin")
    Role.create!(name: "seller_admin")
    Role.create!(name: "registered_user")
  end

  def generate_users
    102.times do |i|
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

    seller_admin = User.create!(
        first_name: "seller",
        last_name: "admin",
        email: "admin@turing.io",
        password: "password",
        seller_id: 1)

    seller_admin.roles << Role.find_by(name: "seller_admin")

    seller_admin2 = User.create!(
        first_name: "Sebastian",
        last_name: "Abondano",
        email: "sabondano1@gmail.com",
        password: "password",
        seller_id: 21)

    seller_admin2.roles << Role.find_by(name: "seller_admin")

    platform_admin = User.create!(
        first_name: "platform",
        last_name: "admin",
        email: "super@turing.io",
        password: "password")

    platform_admin.roles << Role.find_by(name: "platform_admin")

  end

  def generate_sellers

      Seller.create!(
          name: "Johnson & Johnson Inc.",
          email: Faker::Internet.email,
          image_url: "sellers/Ddaniel.jpeg")
      Seller.create!(
          name: "3M",
          email: Faker::Internet.email,
          image_url: "sellers/Adam.jpeg")
      Seller.create!(
          name: "Toyz R Us",
          email: Faker::Internet.email,
          image_url: "sellers/Carmer.jpeg")
      Seller.create!(
          name: "Target",
          email: Faker::Internet.email,
          image_url: "sellers/David.jpeg")
      Seller.create!(
          name: "ESPN",
          email: Faker::Internet.email,
          image_url: "sellers/Drew.jpeg")
      Seller.create!(
          name: "Audi",
          email: Faker::Internet.email,
          image_url: "sellers/Horace.jpeg")
      Seller.create!(
          name: "All Things Inc.",
          email: Faker::Internet.email,
          image_url: "sellers/Jai.jpeg")
      Seller.create!(
          name: "Forever 21",
          email: Faker::Internet.email,
          image_url: "sellers/Jorge.jpeg")
      Seller.create!(
          name: "DVD's We Sell",
          email: Faker::Internet.email,
          image_url: "sellers/Kristina.jpeg")
      Seller.create!(
          name: "Chutes and Ladders",
          email: Faker::Internet.email,
          image_url: "sellers/Justin.jpeg")
      Seller.create!(
          name: "Made in the USA",
          email: Faker::Internet.email,
          image_url: "sellers/Mike-d.jpeg")
      Seller.create!(
          name: "Benelli",
          email: Faker::Internet.email,
          image_url: "sellers/Mike-dao.jpeg")
      Seller.create!(
          name: "General Mills",
          email: Faker::Internet.email,
          image_url: "sellers/Mitch.jpeg")
      Seller.create!(
          name: "Best Buy",
          email: Faker::Internet.email,
          image_url: "sellers/Orion.jpeg")
      Seller.create!(
          name: "Radio Shack",
          email: Faker::Internet.email,
          image_url: "sellers/Other-rachel.jpeg")
      Seller.create!(
          name: "JC Penny",
          email: Faker::Internet.email,
          image_url: "sellers/Rachel.jpeg")
      Seller.create!(
          name: "Timbuk Toys",
          email: Faker::Internet.email,
          image_url: "sellers/Tan.jpeg")
      Seller.create!(
          name: "Kid Creatives",
          email: Faker::Internet.email,
          image_url: "sellers/Steve.jpeg")
      Seller.create!(
          name: "Furniture World",
          email: Faker::Internet.email,
          image_url: "sellers/Sean.jpeg")
      Seller.create!(
          name: "Legends Never Die",
          email: Faker::Internet.email,
          image_url: "sellers/Mike-reeves")
    Seller.create!(
              name: "Groovy Toys",
              email: "sabondano1@gmail.com",
              image_url: "sellers/Sebastian.jpeg")
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

    1.upto(21) do |i|
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
        description: "So much fun you're eyes will bleed!",
        image_url: 'pacman.jpg')
    Category.create!(
        name: "Instruments",
        description: "Music is a beautiful thing, get the tool to make it.",
        image_url: 'nocaster.jpg')
    Category.create!(
        name: "Sports",
        description: "Sports sports sports all day every day.",
        image_url: 'MJ.jpg')
    Category.create!(
        name: "Toys",
        description: "Fun toys for all ages!",
        image_url: 'boba_fett.jpg')
    Category.create!(
        name: "Cars",
        description: "Git in a new whip and ride away to freedom.",
        image_url: 'model_e.jpg')
    Category.create!(
        name: "Comics",
        description: "Funny comics that stand the test of time.",
        image_url: 'comics/action_comics.jpg')
    Category.create!(
        name: "Books",
        description: "Knowledge from trees to your eyes.",
        image_url: 'bible.jpg')
    Category.create!(
        name: "Antiques",
        description: "Old things that are worth a lot. Check them out.",
        image_url: 'chippendale.jpg')
    Category.create!(
        name: "Entertainment",
        description: "Be prepared to be amazed and laugh and cry and be in awe.",
        image_url: 'marilyn.jpg')
    Category.create!(
        name: "Guns",
        description: "All your hunting needs in one stop. The buck stops here.",
        image_url: 'guns.jpg')
  end

  def generate_products

    Product.create(name: "Vintage Atari Gaming System",
                   description: "Take a trip back in time and kill some alien invaders and play some pong in this classic video game console ",
                   image_url: "video_games/atari.jpg",
                   category_id: 1,
                   condition: "good",
                   seller_id: Seller.all.sample.id)

    Product.create(name: "Vintage Gibson 1959 Les Paul",
                   description: "Purchasing this Holy Grail of electric guitars will put you in the same category as guitar legends like Jimmy Page and Michael Bloomfield.",
                   image_url: "guitars/les_paul.jpg",
                   category_id: 2,
                   condition: "excellent",
                   seller_id: Seller.all.sample.id)

    Product.create(name: "Signed Lawrence Taylor Jersey",
                   description: "Own the jersey of the most dangerous linebacker every to set foot on the field.",
                   image_url: "sports/lawrence-taylor.jpg",
                   category_id: 3,
                   condition: "mint",
                   seller_id: Seller.all.sample.id)

    Product.create(name: "AT-AT Set",
                   description: "Take down the rebellion on the icy planet of Hoth with this unique set of AT-AT walkers.",
                   image_url: "toys/atat.jpg",
                   category_id: 4,
                   condition: "good",
                   seller_id: Seller.all.sample.id)

    Product.create(name: "Ferrari California",
                   description: "Drive off into the sunset in what is widely considered to be one of the most attractive automobiles ever made.",
                   image_url: "cars/Ferrari_California.jpg",
                   category_id: 5,
                   condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                   seller_id: Seller.all.sample.id)

    Product.create(name: "Action Comics No. 1",
                   description: "Put off your retirment a few decades and purchase the first appearance of America's most beloved super hero.",
                   image_url: "comics/action_comics.jpg",
                   category_id: 6,
                   condition: "mint",
                   seller_id: Seller.all.sample.id)

    Product.create(name: "First Edition Hobbit",
                   description: "Introduce yourself to Bilbo and Gandalf and their unexpected journey to Lonely Mountain.",
                   image_url: "books/hobbit.jpg",
                   category_id: 7,
                   condition: "poor",
                   seller_id: Seller.all.sample.id)

    Product.create(name: "1920's Tiffany Lamp",
                   description: "Own this gorgeous Tiffany lamp from the golden era of luxury.",
                   image_url: "antiques/tiffany.jpg",
                   category_id: 8,
                   condition: "mint",
                   seller_id: Seller.all.sample.id)

    Product.create(name: "Michael Jackson's Glove",
                   description: "Prove that Billy Jean is not your lover with Michael Jackson's one of a kind diamond studded glove.",
                   image_url: "entertainment/glove.jpg",
                   category_id: 9,
                   condition: "mint",
                   seller_id: Seller.all.sample.id)

    Product.create(name: "Original Walker Colt",
                   description: "Go ahead, make someone's day with this highly sought after Spanish American War classic.",
                   image_url: "guns/colt.jpg",
                   category_id: 10,
                   condition: "good",
                   seller_id: Seller.all.sample.id)

    7.times do |i|
      Product.create(name: "First Edition Hobbit",
                     description: "Introduce yourself to Bilbo and Gandalf and their unexpected journey to Lonely Mountain.",
                     image_url: "books/hobbit.jpg",
                     category_id: 7,
                     condition: "poor",
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Gutenberg Bible",
                     description: Faker::Lorem.paragraph,
                     image_url: "books/gutenberg.jpg",
                     category_id: 7,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "East of Eden",
                     description: Faker::Lorem.paragraph,
                     image_url: "books/east_of_eden.jpg",
                     category_id: 7,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Great Gatsby",
                     description: Faker::Lorem.paragraph,
                     image_url: "books/great_gatsby.jpg",
                     category_id: 7,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Ptolemy",
                     description: Faker::Lorem.paragraph,
                     image_url: "books/ptolemy.jpg",
                     category_id: 7,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Shakespeare",
                     description: Faker::Lorem.paragraph,
                     image_url: "books/shakespeare.jpg",
                     category_id: 7,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Canterbury Tales",
                     description: Faker::Lorem.paragraph,
                     image_url: "books/chaucer.jpg",
                     category_id: 7,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "To Kill a Mockingbird",
                     description: Faker::Lorem.paragraph,
                     image_url: "books/to_kill_a_mockingbird.jpg",
                     category_id: 7,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

    end

    7.times do |i|

      Product.create(name: "Vintage Atari Gaming System",
                     description: "Take a trip back in time and kill some alien invaders and play some pong in this classic video game console ",
                     image_url: "video_games/atari.jpg",
                     category_id: 1,
                     condition: "good",
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Vintage Nintendo Gaming System",
                     description: Faker::Lorem.paragraph,
                     image_url: "video_games/nes.jpg",
                     category_id: 1,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Vintage Super Nintendo Gaming System",
                     description: Faker::Lorem.paragraph,
                     image_url: "video_games/super_nintendo.jpg",
                     category_id: 1,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Vintage Playstation Gaming System",
                     description: Faker::Lorem.paragraph,
                     image_url: "video_games/playstation.jpg",
                     category_id: 1,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Vintage Sega Genesis Gaming System",
                     description: Faker::Lorem.paragraph,
                     image_url: "video_games/sega.jpg",
                     category_id: 1,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "GoldenEye",
                     description: Faker::Lorem.paragraph,
                     image_url: "video_games/james_bond.jpg",
                     category_id: 1,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

    end


    7.times do |i|

      Product.create(name: "Action Comics No. 1",
                     description: "Put off your retirment a few decades and purchase the first appearance of America's most beloved super hero.",
                     image_url: "comics/action_comics.jpg",
                     category_id: 6,
                     condition: "mint",
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Batman",
                     description: Faker::Lorem.paragraph,
                     image_url: "comics/batman.jpg",
                     category_id: 6,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Captain America",
                     description: Faker::Lorem.paragraph,
                     image_url: "comics/captain_america.jpg",
                     category_id: 6,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Fantastic Four",
                     description: Faker::Lorem.paragraph,
                     image_url: "comics/fantastic_four.jpg",
                     category_id: 6,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Hulk vs. Wolverine",
                     description: Faker::Lorem.paragraph,
                     image_url: "comics/hulk_v_wolverine.jpg",
                     category_id: 6,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Spiderman",
                     description: Faker::Lorem.paragraph,
                     image_url: "comics/spiderman.jpg",
                     category_id: 6,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Wolverine",
                     description: Faker::Lorem.paragraph,
                     image_url: "comics/wolverine.jpg",
                     category_id: 6,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "XMEN",
                     description: Faker::Lorem.paragraph,
                     image_url: "comics/xmen.jpg",
                     category_id: 6,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

    end

    7.times do |i|
      Product.create(name: "Ferrari California",
                     description: "Drive off into the sunset in what is widely considered to be one of the most attractive automobiles ever made.",
                     image_url: "cars/Ferrari_California.jpg",
                     category_id: 5,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Bugatti",
                     description: Faker::Lorem.paragraph,
                     image_url: "cars/bugatti.jpg",
                     category_id: 5,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "BMW 2002 tii",
                     description: Faker::Lorem.paragraph,
                     image_url: "cars/bmw_2002_tii.jpg",
                     category_id: 5,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Lamborghini 350",
                     description: Faker::Lorem.paragraph,
                     image_url: "cars/lamborghini_350.jpg",
                     category_id: 5,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Mercedes 300 SL",
                     description: Faker::Lorem.paragraph,
                     image_url: "cars/mercedes_300sl.jpg",
                     category_id: 5,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Porsche 912",
                     description: Faker::Lorem.paragraph,
                     image_url: "cars/Porsche_912.jpg",
                     category_id: 5,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Shelby Cobra",
                     description: Faker::Lorem.paragraph,
                     image_url: "cars/shelby_cobra.jpg",
                     category_id: 5,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)
    end



    7.times do |i|
      Product.create(name: "Vintage Gibson 1959 Les Paul",
                     description: "Purchasing this Holy Grail of electric guitars will put you in the same category as guitar legends like Jimmy Page and Michael Bloomfield.",
                     image_url: "guitars/les_paul.jpg",
                     category_id: 2,
                     condition: "excellent",
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Fender Jaguar",
                     description: Faker::Lorem.paragraph,
                     image_url: "guitars/jag.jpg",
                     category_id: 2,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Fender Stratocaster",
                     description: Faker::Lorem.paragraph,
                     image_url: "guitars/stratocaster.jpg",
                     category_id: 2,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Gibson SG",
                     description: Faker::Lorem.paragraph,
                     image_url: "guitars/SG.jpg",
                     category_id: 2,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Fender Telecaster",
                     description: Faker::Lorem.paragraph,
                     image_url: "guitars/tele.jpg",
                     category_id: 2,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Gibson L5",
                     description: Faker::Lorem.paragraph,
                     image_url: "guitars/l5.jpg",
                     category_id: 2,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "D'Angelico",
                     description: Faker::Lorem.paragraph,
                     image_url: "guitars/d'angelico.jpg",
                     category_id: 2,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "D'Angelico",
                     description: Faker::Lorem.paragraph,
                     image_url: "guitars/es_335.jpg",
                     category_id: 2,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)
    end


    7.times do |i|

      Product.create(name: "AT-AT Set",
                     description: "Take down the rebellion on the icy planet of Hoth with this unique set of AT-AT walkers.",
                     image_url: "toys/atat.jpg",
                     category_id: 4,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Rock-Em Sock-Em Robots",
                     description: Faker::Lorem.paragraph,
                     image_url: "toys/robots.jpg",
                     category_id: 4,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Han Solo",
                     description: Faker::Lorem.paragraph,
                     image_url: "toys/han_solo.jpg",
                     category_id: 4,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Vintage Linemar",
                     description: Faker::Lorem.paragraph,
                     image_url: "toys/linemar.jpg",
                     category_id: 4,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Pinochio",
                     description: Faker::Lorem.paragraph,
                     image_url: "toys/pinochio.jpg",
                     category_id: 4,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Rockinghorse",
                     description: Faker::Lorem.paragraph,
                     image_url: "toys/rockinghorse.jpg",
                     category_id: 4,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Spaceship",
                     description: Faker::Lorem.paragraph,
                     image_url: "toys/spaceship.jpg",
                     category_id: 4,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "X-Wing",
                     description: Faker::Lorem.paragraph,
                     image_url: "toys/x_wing.jpg",
                     category_id: 4,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)
    end

    7.times do |i|

      Product.create(name: "Signed Lawrence Taylor Jersey",
                     description: "Own the jersey of the most dangerous linebacker every to set foot on the field.",
                     image_url: "sports/lawrence-taylor.jpg",
                     category_id: 3,
                     condition: "mint",
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Michael Jordan Signed Basketball",
                     description: Faker::Lorem.paragraph,
                     image_url: "sports/mike.jpg",
                     category_id: 3,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Babe Ruth Autographed Baseball",
                     description: Faker::Lorem.paragraph,
                     image_url: "sports/babe_ruth.JPG",
                     category_id: 3,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Jake LaMotta Signed Photograph",
                     description: Faker::Lorem.paragraph,
                     image_url: "sports/jake.jpg",
                     category_id: 3,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Emmit Smith Signed Football",
                     description: Faker::Lorem.paragraph,
                     image_url: "sports/emmit.jpg",
                     category_id: 3,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Lary Bird and Magic Johnson Signed Photograph",
                     description: Faker::Lorem.paragraph,
                     image_url: "sports/larry_magic.jpg",
                     category_id: 3,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Leon Spinks Signed Gloves",
                     description: Faker::Lorem.paragraph,
                     image_url: "sports/leon_spinks.jpg",
                     category_id: 3,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

    end

    7.times do |i|

      Product.create(name: "1920's Tiffany Lamp",
                     description: "Own this gorgeous Tiffany lamp from the golden era of luxury.",
                     image_url: "antiques/tiffany.jpg",
                     category_id: 8,
                     condition: "mint",
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Antique Chairs",
                     description: Faker::Lorem.paragraph,
                     image_url: "antiques/chairs.jpg",
                     category_id: 8,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Antique Chest",
                     description: Faker::Lorem.paragraph,
                     image_url: "antiques/chest.jpg",
                     category_id: 8,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Old Teapot",
                     description: Faker::Lorem.paragraph,
                     image_url: "antiques/teapot.jpg",
                     category_id: 8,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Chinese Vase",
                     description: Faker::Lorem.paragraph,
                     image_url: "antiques/vase.jpg",
                     category_id: 8,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Antique Persian Rug",
                     description: Faker::Lorem.paragraph,
                     image_url: "antiques/persian_rug.jpg",
                     category_id: 8,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Antique Desk",
                     description: Faker::Lorem.paragraph,
                     image_url: "antiques/desk.jpg",
                     category_id: 8,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)
    end

    7.times do |i|

      Product.create(name: "Original Walker Colt",
                     description: "Go ahead, make someone's day with this highly sought after Spanish American War classic.",
                     image_url: "guns/colt.jpg",
                     category_id: 10,
                     condition: "good",
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Antique Blunderbuss",
                     description: Faker::Lorem.paragraph,
                     image_url: "guns/blunderbuss.jpg",
                     category_id: 10,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Antique Charing Cross",
                     description: Faker::Lorem.paragraph,
                     image_url: "guns/charing_cross_gun.jpg",
                     category_id: 10,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Antique Italian Pistol",
                     description: Faker::Lorem.paragraph,
                     image_url: "guns/italian_pistol.jpg",
                     category_id: 10,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Antique Spanish Gun",
                     description: Faker::Lorem.paragraph,
                     image_url: "guns/spanish_gun.jpg",
                     category_id: 10,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Original Winchester Rifle",
                     description: Faker::Lorem.paragraph,
                     image_url: "guns/winchester.jpg",
                     category_id: 10,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)
    end

    5.times do |i|

      Product.create(name: "Michael Jackson's Glove",
                     description: "Prove that Billy Jean is not your lover with Michael Jackson's one of a kind diamond studded glove.",
                     image_url: "entertainment/glove.jpg",
                     category_id: 9,
                     condition: "mint",
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Star Trek TOS Phaser",
                     description: Faker::Lorem.paragraph,
                     image_url: "entertainment/phaser.jpg",
                     category_id: 9,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Darth Vader Helmet",
                     description: Faker::Lorem.paragraph,
                     image_url: "entertainment/vader.jpg",
                     category_id: 9,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Marlon Brando's Godfather Hat",
                     description: Faker::Lorem.paragraph,
                     image_url: "entertainment/godfather.jpg",
                     category_id: 9,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)

      Product.create(name: "Elvis Signature",
                     description: Faker::Lorem.paragraph,
                     image_url: "entertainment/elvis.jpg",
                     category_id: 9,
                     condition: ["fair", "good", "poor", "mint", "excellent"].sample,
                     seller_id: Seller.all.sample.id)
    end


    # Category.all.each do |category|
    #   50.times do |i|
    #     product = Product.create!(
    #         name: Faker::Commerce.product_name,
    #         description: Faker::Lorem.paragraph,
    #         image_url: Faker::Avatar.image,
    #         category_id: category.id,
    #         condition: ["fair", "good", "poor", "mint", "excellent"].sample,
    #         seller_id: Seller.all.sample.id)
    #   end
    # end
  end

  def generate_auctions
    Auction.create!(product_id: 1,
                    starting_time: DateTime.civil(2015, 8, 20, 5, 0, 0, 0),
                    ending_time: DateTime.civil(2015, 8, 25, 5, 0, 0, 0),
                    starting_price: 100.00)

    Auction.create!(product_id: 2,
                    starting_time: DateTime.now,
                    ending_time: DateTime.now + 10.days,
                    starting_price: 200.00)

    Auction.create!(product_id: 3,
                    starting_time: DateTime.now,
                    ending_time: DateTime.now + 10.days,
                    starting_price: 2500.00)

    Auction.create!(product_id: 4,
                    starting_time: DateTime.now,
                    ending_time: DateTime.now + 10.days,
                    starting_price: 2000.00)

    Auction.create!(product_id: 5,
                    starting_time: DateTime.now,
                    ending_time: DateTime.now + 10.days,
                    starting_price: 600.00)

    Auction.create!(product_id: 6,
                    starting_time: DateTime.now,
                    ending_time: DateTime.now + 10.days,
                    starting_price: 700.00)

    Auction.create!(product_id: 7,
                    starting_time: DateTime.now,
                    ending_time: DateTime.now + 10.days,
                    starting_price: 500.00)

    Auction.create!(product_id: 8,
                    starting_time: DateTime.now,
                    ending_time: DateTime.now + 10.days,
                    starting_price: 500.00)

    Auction.create!(product_id: 9,
                    starting_time: DateTime.now,
                    ending_time: DateTime.now + 10.days,
                    starting_price: 500.00)

    Auction.create!(product_id: 10,
                    starting_time: DateTime.now,
                    ending_time: DateTime.now + 10.days,
                    starting_price: 500.00)

    Auction.create!(product_id: 90,
                    starting_time: DateTime.now,
                    ending_time: DateTime.now + 10.days,
                    starting_price: 500.00)
  end

  def generate_bids
    Bid.create!(user_id: 101,
                auction_id: 1,
                amount: 150)

    Bid.create!(user_id: 5,
                auction_id: 1,
                amount: 250)

    Bid.create!(user_id: 101,
                auction_id: 1,
                amount: 350)

    Bid.create!(user_id: 101,
                auction_id: 2,
                amount: 5000)

    Bid.create!(user_id: 101,
                auction_id: 3,
                amount: 3050)

    Bid.create!(user_id: 101,
                auction_id: 4,
                amount: 5050)
  end


end
Seed.start
