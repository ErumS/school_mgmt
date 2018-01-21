FactoryGirl.define do
  factory :school do
    name Faker::Name.name
    address Faker::Address.street_address
    phone_no "65784938476"
  end
end
