FactoryBot.define do
  factory :feature do
    id { 1 }
    mag { 0.91 }
    place { "8 km W of Cobb, CA" }
    time { 1712757957730 }
    url { "https://earthquake.usgs.gov/earthquakes/eventpage/nc74032261" }
    tsunami { 0 }
    magType { "md" }
    title { "M 0.9 - 8 km W of Cobb, CA" }
    longitude { -122.8093338 }
    latitude { 38.831501 }
    magnitude { 1.98 }
    externalId { "nc74032311" }
  end
end
