team = Team.find_or_create_by!(slug: "nerdgeschoss") do |team|
  team.assign_attributes name: "nerdgeschoss", generate_invoice_number: false
end
team.users.find_or_create_by!(email: "admin@nerdgeschoss.de") do |user|
  user.assign_attributes first_name: "Admin", last_name: "Admin", password: "adminadmin", roles: ["admin"]
end
