import 'package:flutter/material.dart';

import '../colorConstraint.dart';
import 'TextFieldContainer.dart';

class RoundedPasswordFormField extends StatefulWidget {
  final onSaved;
  final validator;
  String hintValue;
  final passController;
  RoundedPasswordFormField(
      {Key? key,
      required this.onSaved,
      this.validator,
      this.hintValue = 'Password',
      TextEditingController? this.passController})
      : super(key: key);

  @override
  _RoundedPasswordFormFieldState createState() =>
      _RoundedPasswordFormFieldState();
}

class _RoundedPasswordFormFieldState extends State<RoundedPasswordFormField> {
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: widget.passController,
        obscureText: !_showPassword,
        onSaved: (e) {
          widget.onSaved(e);
        },
        validator: (password) {
          return widget.validator(password);
        },
        cursorColor: PrimaryColor,
        decoration: InputDecoration(
          hintText: widget.hintValue,
          icon: Icon(
            Icons.lock,
            color: PrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.visibility,
              color: !this._showPassword ? Colors.grey : PrimaryColor,
            ),
            onPressed: () {
              setState(() => this._showPassword = !this._showPassword);
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// class RoundedPasswordFormField extends StatelessWidget {
//   final onSaved;
//   final validator;
//   const RoundedPasswordFormField({
//     Key? key,
//     required this.onSaved,
//     this.validator,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFieldContainer(
//       child: TextFormField(
//         obscureText: true,
//         onSaved: (e) {
//           onSaved(e);
//         },
//         validator: (password) {
//           validator(password);
//         },
//         cursorColor: PrimaryColor,
//         decoration: InputDecoration(
//           hintText: "Password",
//           icon: Icon(
//             Icons.lock,
//             color: PrimaryColor,
//           ),
//           suffixIcon: Icon(
//             Icons.visibility,
//             color: PrimaryColor,
//           ),
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }
// }
