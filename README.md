# rails-Blog
Plik Rails users.txt zawiera nazwy i hasła użytkowników w bazie danych aplikacji.

Przed uruchomieniem należy dodać uprawnienia dla kontenera

chmod -R 777 <ścieżka do katalogu projektu>

Aby uruchomić aplikację rails należy przejść do katalogu aplikacji
i wykonać poniższe komendy:

bundle install

rake db:create (potwierdza istnienie bazy danych)

rake db:migrate

(w konsoli Rails) komendy do utworzenia indeksu elastic search

Post.__elasticsearch__.create_index!(force: true)

Post.import


rails s -b 0.0.0.0 -p <numer_portu_kontnera>


Aby uruchomić mailcatcher należy użyć komendy
mailcatcher --http-ip 0.0.0.0 --smtp-ip 0.0.0.0 &

Aby przypisać użytkownikowi rolę administratora, należy w konsoli Rails wykonać:

new_admin = User.find_by(email: 'email administratora')

new_admin.add_role(:admin)

new_admin.has_role?(:admin)
