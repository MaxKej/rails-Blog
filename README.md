# rails-Blog
Plik Rails users.txt zawiera nazwy i hasła użytkowników w bazie danych aplikacji.

Przed uruchomieniem należy dodać uprawnienia dla kontenera
chmod -R 777 <ścieżka do katalogu projektu>

Aby uruchomić aplikacją rails należy przejść do katalogu aplikacji i wykonać poniższe komendy
bundle install
rails s -b 0.0.0.0 -p <numer portu kontenera>

Aby przypisać użytkownikowi rolę administratora, należy w konsoli Rails wykonać:
new_admin = User.find_by(email: 'email administratora')
new_admin.add_role(:admin)
new_admin.has_role?(:admin)
