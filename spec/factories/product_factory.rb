FactoryGirl.define do
  factory :product do
    title       'Ruby Book'
    description 'This is a ruby book that is awesome!'
    price       12.99
    published   true
    association :category
  end
end