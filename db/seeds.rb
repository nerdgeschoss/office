DatabaseCleaner.clean_with :truncation
FactoryBot.create :user, first_name: "Admin", last_name: "Admin", email: "admin@nerdgeschoss.de", password: "adminadmin"
