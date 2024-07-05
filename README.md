# rails-Blog
Aby przypisać użytkownikowi rolę administratora, należy w konsoli Rails wykonać:
new_admin = User.find_by(email: 'email administratora')
new_admin.add_role(:admin)
new_admin.has_role?(:admin)
