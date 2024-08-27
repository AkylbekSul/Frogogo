# db/seeds.rb

Product.create!(
  [
    {
      name: "Goodyear Bluetooth Speaker",
      description: "Беспроводная колонка Goodyear Bluetooth Speaker",
      price: 1599.99,
      image: nil
    },
    {
      name: "SwissOak",
      description: "Плащ-дождевик SwissOak",
      price: 799.99,
      image: nil
    },
    {
      name: "Sweet Dreams",
      description: "Женский домашний костюм Sweet Dreams",
      price: 799.99,
      image: nil
    }
  ]
).each_with_index do |product, index|
  product.image.attach(
    io: File.open(Rails.root.join('app', 'assets', 'images', ["speaker.png", "cloak.jpg", "suit.png"][index])),
    filename: ["speaker.png", "cloak.jpg", "suit.png"][index],
    content_type: 'image/png'
  )
end
