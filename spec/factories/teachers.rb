FactoryGirl.define do
  factory :teacher do
    name Faker::Name.name
    subject_name Faker::Educator.course
    salary Faker::Number.between(10_000, 90_000)
  end
end
