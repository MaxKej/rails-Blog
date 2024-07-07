# rails-Blog
W pliku compose.yaml należy podać ścieżkę lokalnego katalogu, w którym będą zapisywane pliki projektu.
Plik Rails users.txt zawiera nazwy i hasła użytkowników w bazie danych aplikacji.

W kontenerze należy wykonać komendy
sudo apt install nodejs
sudo apt install npm


Aby przypisać użytkownikowi rolę administratora, należy w konsoli Rails wykonać:
new_admin = User.find_by(email: 'email administratora')
new_admin.add_role(:admin)
new_admin.has_role?(:admin)
