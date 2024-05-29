import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:technicaltestfan/view/page/LoginPage.dart';
import 'package:technicaltestfan/viewmodel/UserViewModel.dart';

class ForgotPasswordWidget extends StatefulWidget {
  const ForgotPasswordWidget({super.key});

  @override
  _ForgotPasswordWidgetState createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  TextEditingController emailController = TextEditingController();

  final UserViewModel _userViewModel =
      UserViewModel(); 

  void resetPassword(BuildContext context) async {
    try {
      await _userViewModel.resetPasswordWithEmail(emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset email sent. Please check your inbox.'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print('Error during password reset: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Failed to send password reset email. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double topMargin = screenHeight * 0.05;

    return Center(
      child: Container(
          margin: EdgeInsets.only(top: topMargin),
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              "Forgot Password",
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
            SizedBox(height: 24.0),
            SizedBox(
              width: double.infinity, 
              child: ElevatedButton(
                  onPressed: () {
                    resetPassword(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), 
                    ),
                  ),
                  child: Text(
                    'Send',
                    style: GoogleFonts.libreBaskerville(color: Colors.white),
                  )),
            ),
            SizedBox(
              height: 16.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "*Note : You will have recieved email",
                style: GoogleFonts.libreBaskerville(
                    color: Colors.black45, fontSize: 14),
              ),
            )
          ])),
    );
  }
}
