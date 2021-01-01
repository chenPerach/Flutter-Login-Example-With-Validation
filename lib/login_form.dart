import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: this.formkey,
      child: Column(
        children: [
          Container(
            child: EmailEditText(
              enabledBorderColor: Colors.blue,
            ),
            constraints: BoxConstraints(maxWidth: 350),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: PasswordEditText(
              enabledBorderColor: Colors.blue,
            ),
            constraints: BoxConstraints(maxWidth: 350),
          ),
          // SizedBox(height: this.formkey.currentState.validate() ? 20 : 0),
          Container(
            width: 350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  child: Text("submit"),
                  onPressed: () {
                    if (this.formkey.currentState.validate()) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "processing..."))); //shows a massege on screen
                      /**
                      * all of the server side information logging is gonna go in here.
                      */
                    }
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                Text("dont have an account?"),
                TextButton(
                  child: Text("Sign up"),
                  style: TextButton.styleFrom(),
                  onPressed: () {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("you should really add somthing here..."),
                    ));
                    /**
                   * preform sign up stuff
                   */
                  },
                ),
              ],
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}

/**
 * custom password text field with validation
 */
class PasswordEditText extends StatelessWidget {
  final Color enabledBorderColor;
  PasswordEditText({this.enabledBorderColor});
  @override
  Widget build(BuildContext context) {
    return CustomFormEditText(
      hint: "password",
      enabledColor: this.enabledBorderColor,
      validetor: validate,
      obscured: true,
    );
  }

  String validate(String value) {
    if (value.isEmpty) return "please enter text";
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    var regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(value))
        return "should contain at least one upper case character";
      if (!RegExp(r'^(?=.*?[a-z])').hasMatch(value))
        return "should contain at least one lower case character";
      if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value))
        return "should contain at least number";
      if (!RegExp(r'^(?=.*?[!@#\$&*~]).{8,}').hasMatch(value))
        return "should contain at least one special character";
    }
  }
}

/**
 * custom password email field with validation
 */
class EmailEditText extends StatelessWidget {
  final Color enabledBorderColor;
  EmailEditText({this.enabledBorderColor = Colors.blue});
  @override
  Widget build(BuildContext context) {
    return CustomFormEditText(
      hint: "email",
      enabledColor: this.enabledBorderColor,
      validetor: validate,
    );
  }

  String validate(String value) {
    if (value.isEmpty) return "please enter text";
    return RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)
        ? null
        : "email is not valid";
  }
}
/**
 * this class is where I costumized the default TextFormField and made it my own
 * custom changes are:
 * - added border
 * - different colors for each state
 * - ease of use.
 */
class CustomFormEditText extends StatelessWidget {
  final String hint;
  final Color enabledColor;
  final String Function(String value) validetor;
  final bool obscured;
  CustomFormEditText(
      {@required this.hint,
      this.enabledColor = Colors.blue,
      this.validetor,
      this.obscured = false});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: this.obscured,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: this.validetor,
      decoration: InputDecoration(
        labelText: this.hint,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: this.enabledColor)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
