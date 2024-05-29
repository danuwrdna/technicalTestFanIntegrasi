#Bahasa atau framework
FLUTTER
# Design pattern
- Design pattern yang di gunakan adalah MVVM ( Model view view model )
# principle code
  single responsbility, yang artinya saya membuat suatu void untuk satu tujuan saja, contoh jika untuk membuat password tidak terlihat maka saya membuat void hidePassword yang didalamnya hanya logic yang berkaitan dnegan hide pasword.
# Stack yang di gunakan
- Lottie
- Provider
- Firebase core
- Firebase auth
- cloud firestore
# Penejelasan aplikasi
-  pertama
  pengguna akan masuk ke halaman splash screen, yang mempunyai dua button untuk sign in atau sign up
-  kedua
  Pengguna akan memilih button dan halaman yang akan di tampilkan sesuai dengan button yang pengguna pilih
- ketiga untuk login
  pengguna di haruskan register dahulu jika belum punya akun, nanti pengguna akan isi form register email dan password setelah sudah pengguna akan dikirim kan link verifikasi email, jika sudah membuat maka data pengguna tadi sudah masuk ke cloud firestore dan sudah bisa di gunakan untuk login
- keempat reset password
 jika pengguna lupa password, maka pengguna klik forgot pasword yang ada di halaman login, setelah itu pengguna akan di minta emailnya, dan akan dikirimkan tautan link reset password, dan pengguna bisa melakukan rset password dan melakukan login ulang
- kelima home page
halaman home page berisi data pengguna yang sudah di daftarkan dan masuk ke cloud firestroe, data pengguna yang di tampilkan adalah email dan status, data pengguna yang disimpan adalah email, password, dan email verifikasi ( boolean ).
home page dalam menampilkan data emnggunakan table yang mempunyai 3 colum colum pertama : email, colum kedua : status, colum ketiga : action untuk memverifikasi pengguna
- keenam cari user
pencarian user bisa di lakukan di halaman home page tinggal klik text field yang ada di home page masukkan input maka data langsung di cari.
- keetujuh filter user verifikasi dan belum verifikasi
  tinggal klik icon sebelah icon search yang di halaman home page dan tinggal pilih saja apa mau di tampilkan user yang sudah verified atau belum
# video demo
- note: untuk video reset password dan email verification tidak di tunjukkan, tapi fitur ada dan sudah berjlaan normal, karena reset password dan email verifikasi ini tautannya kirim ke gmail sesuai yang di daftarkan, jadi klo di videokan itu akan membuka aplikasi gmail dan itu sifatnya privasi
link google drive :
https://drive.google.com/file/d/1832GV3qv2s6_cagkXyRzR2LbaX5YMsGU/view?usp=sharing

