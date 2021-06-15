import 'package:ctse/Home/Background.dart';
import 'package:ctse/Login/SignInScreen.dart';
import 'package:ctse/SignUp/SignUpScreen.dart';
import 'package:ctse/Student/StudentHome.dart';
import 'package:ctse/common/rounded_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../colorConstraint.dart';
import 'admin_home.dart';

class BodyContainer extends StatelessWidget {
  const BodyContainer({Key? key}) : super(key: key);

  void checkLoginUser(BuildContext context) async {
    var user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user.email != "admin@gmail.com") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return StudentHome();
            },
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return AdminHomeScreen();
            },
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    checkLoginUser(context);
    Size size = MediaQuery.of(context).size;
    return Background(
      key: null,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "STUDENT EDUCATION SYSTEM",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: HexColor('#f44336')),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "images/u2.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
                text: 'Login',
                press: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }),
            SizedBox(height: size.height * 0.01),
            RoundedButton(
              text: 'Sign up',
              press: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              color: PrimaryLightColor,
              textColor: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
