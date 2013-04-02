# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shop do
    url "demo1.myshopify.com"
    paid false
    script_installed false
  end
end
