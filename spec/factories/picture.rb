# frozen_string_literal: true

FactoryBot.define do
  factory :picture do
    image { Rack::Test::UploadedFile.new('spec/fixtures/qwerty.jpg', 'image/jpg') }
    status { 'pending' }
    association :user
  end
end
