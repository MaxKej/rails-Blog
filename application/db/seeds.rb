# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.create([
              { email: 'user4@test.com', password: '#User4' },
              { email: 'user5@test.com', password: '#User5' },
              { email: 'user6@test.com', password: '#User6' },
              { email: 'user7@test.com', password: '#User7' },
              { email: 'user8@test.com', password: '#User8' }
            ])