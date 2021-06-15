import 'package:ctse/Home/admin_home.dart';
import 'package:ctse/SignUp/SignUpScreen.dart';
import 'package:ctse/Student/StudentHome.dart';
import 'package:ctse/common/RoundedInputFormField.dart';
import 'package:ctse/common/RoundedPasswordField.dart';
import 'package:ctse/common/rounded_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'AlreadyAccountContainer.dart';
import 'background.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BodyContainer extends StatefulWidget {
  const BodyContainer({Key? key}) : super(key: key);

  @override
  _BodyContainerState createState() => _BodyContainerState();
}

class _BodyContainerState extends State<BodyContainer> {
  var _emailAddress;
  var _password;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
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

  void signIn(BuildContext context, func) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: _emailAddress,
          password: _password,
        )
        .then((authUser) => {
              func(),
              _showToast(
                  message: 'Successfully login!!',
                  color: Colors.greenAccent,
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  )),
              print('authUser : ${authUser.user!.email}'),
              if (authUser.user!.email == 'admin@gmail.com')
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AdminHomeScreen();
                      },
                    ),
                  )
                }
              else
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return StudentHome();
                      },
                    ),
                  )
                }
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
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "images/s1.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputFormField(
                hintText: "Your Email Address",
                onSaved: (value) {
                  _emailAddress = value;
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
              RoundedPasswordFormField(onSaved: (value) {
                _password = value;
              }, validator: (password) {
                if (password.toString().trim().isEmpty) {
                  return "password is required";
                }
                return null;
              }),
              RoundedButton(
                text: "LOGIN",
                press: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    EasyLoading.show(status: 'loading...');
                    // print(_emailAddress);
                    FocusScope.of(context).unfocus();
                    signIn(context, () {
                      formKey.currentState!.reset();
                      EasyLoading.dismiss();
                    });
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAccount(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
