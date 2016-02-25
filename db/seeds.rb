# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'mp.csv'))

CSV.foreach('lib/seeds/mp.csv', encoding: "ISO-8859-1:UTF-8", :headers => true) do |row|
  t = Mp.new
  t.name = row['name']
  t.address = row['address']
  t.city = row['city']
  t.country = row['country']
  t.continent = row['continent']
  t.geoX = row['geoX']
  t.geoY = row['geoY']
  t.save!
  puts "#{t.name}, #{t.city} ---/////----, #{ row['name']}, #{row['city']}  -----|||-----"
end

puts "There are now #{Mp.count} rows "