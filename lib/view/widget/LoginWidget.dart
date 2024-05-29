import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:technicaltestfan/view/page/ForgotPasswordPage.dart';
import 'package:flutter/gestures.dart';
import 'package:technicaltestfan/view/page/HomePage.dart';
import 'package:technicaltestfan/view/page/RegisterPage.dart';
import 'package:technicaltestfan/viewmodel/UserViewModel.dart';
import 'package:lottie/lottie.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  final UserViewModel userViewModel = UserViewModel();
  bool obscureText = true;

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void loginWithEmailAndPassword(BuildContext context) async {
    try {
      setState(() {
        isLoading = true; // Aktifkan animasi Lottie
      });

      await userViewModel.signInWithEmailAndPassword(
          emailController.text, passwordController.text);

      setState(() {
        isLoading = false; // Matikan animasi Lottie
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login successful'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      print('Error during login: $e');
      setState(() {
        isLoading = false; // Matikan animasi Lottie jika terjadi kesalahan
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed. Please try again.'),
        ),
      );
    }
  }

  void navigateToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
    );
  }

  void navigateToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double topMargin = screenHeight * 0.10;

    return ListView(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(top: topMargin),
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 40.0),
                if (isLoading)
                  Lottie.asset(
                    'assets/animation/loadAnimate.json',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                Text(
                  "Sign in",
                  style: GoogleFonts.libreBaskerville(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: GoogleFonts.libreBaskerville(),
                    hintText: 'Enter your email',
                    hintStyle: GoogleFonts.libreBaskerville(),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: passwordController,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: GoogleFonts.libreBaskerville(),
                    hintText: 'Enter your password',
                    hintStyle: GoogleFonts.libreBaskerville(),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: togglePasswordVisibility,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: navigateToForgotPassword,
                    child: Text(
                      "Forgot password",
                      style: GoogleFonts.libreBaskerville(
                        fontSize: 14,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        loginWithEmailAndPassword(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Sign in',
                        style:
                            GoogleFonts.libreBaskerville(color: Colors.white),
                      )),
                ),
                SizedBox(height: 40.0),
                Text(
                  "Or Continue With",
                  style: GoogleFonts.libreBaskerville(
                      fontSize: 14, color: Colors.black45),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.facebook, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 180, 179, 179),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 10.0,
                          height: 10.0,
                          child: Image.asset(
                            'assets/images/google.png',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.apple, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: 'If you don\'t have an account, ',
                        style: GoogleFonts.libreBaskerville(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ])),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'you can register here',
                        style: GoogleFonts.libreBaskerville(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => navigateToRegister(context),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
