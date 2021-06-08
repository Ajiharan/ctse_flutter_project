import 'package:ctse/Home/Background.dart';
import 'package:ctse/common/rounded_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../colorConstraint.dart';

class BodyContainer extends StatelessWidget {
  const BodyContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      key: null,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "STUDENT EDUCATION SYSTEM",
              style: TextStyle(fontWeight: FontWeight.bold),
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
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => LoginScreen()));
                }),
            SizedBox(height: size.height * 0.01),
            RoundedButton(
              text: 'Sign up',
              press: () {
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => SignUpScreen()));
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
