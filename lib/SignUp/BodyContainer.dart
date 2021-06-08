import 'package:ctse/Login/AlreadyAccountContainer.dart';
import 'package:ctse/Login/SignInScreen.dart';
import 'package:ctse/common/RoundedInputFormField.dart';
import 'package:ctse/common/RoundedPasswordField.dart';
import 'package:ctse/common/divider.dart';
import 'package:ctse/common/rounded_buttons.dart';
import 'package:ctse/common/socialIcons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'background.dart';

class BodyContainer extends StatefulWidget {
  const BodyContainer({Key? key}) : super(key: key);

  @override
  _BodyContainerState createState() => _BodyContainerState();
}

class _BodyContainerState extends State<BodyContainer> {
  var _emailAddress;
  var _password;
  var _cpassword;
  final TextEditingController passController = TextEditingController(text: "");
  late FToast fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void signUp(BuildContext context, func) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: _emailAddress,
          password: _password,
        )
        .then((authUser) => {
              func(),
              _showToast(
                  message: 'Successfully registered!!',
                  color: Colors.greenAccent,
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  )),
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => HomePage()))
            })
        .catchError((onError) {
      func();
      _showToast(
          message: onError.message,
          color: Colors.redAccent,
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
          ));
    });
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  _showToast({message, color, icon}) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.white70),
            ),
          )
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGNUP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "images/u1.svg",
                height: size.height * 0.35,
              ),
              RoundedInputFormField(
                hintText: "Your Email",
                onSaved: (emailAddress) {
                  _emailAddress = emailAddress;
                },
                validator: (emailId) {
                  if (emailId.toString().trim().isEmpty) {
                    return 'email address is required';
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(emailId.toString().trim())) {
                    return 'Invalid email address';
                  }
                  return null;
                },
              ),
              RoundedPasswordFormField(
                  onSaved: (password) {
                    _password = password;
                  },
                  passController: passController,
                  validator: (password) {
                    if (password.toString().trim().isEmpty) {
                      return "password is required";
                    } else if (password.toString().trim().length < 6) {
                      return "password contain minimum 6 digits";
                    }
                    return null;
                  }),
              RoundedPasswordFormField(
                onSaved: (cPassword) {
                  _cpassword = cPassword;
                },
                validator: (cPassword) {
                  if (cPassword.toString().trim().isEmpty) {
                    return "conform password is required";
                  } else if (cPassword != passController.text) {
                    return 'Password Not match';
                  }

                  return null;
                },
                hintValue: 'Conform Password',
              ),
              RoundedButton(
                text: "SIGNUP",
                press: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    // print(_emailAddress);
                    FocusScope.of(context).unfocus();
                    signUp(context, () {
                      formKey.currentState!.reset();
                      passController.clear();
                    });
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAccount(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocalIcon(
                    iconSrc: "images/facebook.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "images/twitter.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "images/google-plus.svg",
                    press: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
