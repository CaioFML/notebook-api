namespace :dev do
  desc 'Configura o ambiente de desenvolvimento'
  task setup: :environment do
    puts 'Cadastrando os contatos...'

    100.times do
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.birthday(min_age: 18, max_age: 65)
      )
    end

    puts 'Contatos cadastrados com sucesso!'
  end
end
