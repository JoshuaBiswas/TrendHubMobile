import 'package:application/screens/authenticate/sign_in.dart';
import 'package:application/services/auth.dart';
import 'package:application/shared/constants.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String confirmPassword = '';
  String error = '';
  //false is creative
  bool choose = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign up'),
        actions: <Widget>[
          TextButton.icon(
              icon: const Icon(Icons.person),
              label: const Text("Sign In"),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const SignIn(),
                  ),
                );
              })
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              //Email Field
              const SizedBox(height: 20.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Email"),
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  }),

              //Password Field
              const SizedBox(height: 20.0),
              TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: "Password"),
                  validator: (val) =>
                      val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  }),

              //Confirm password Field
              const SizedBox(height: 20.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(
                      hintText: "Confirm Password"),
                  validator: (val) =>
                      val != password ? 'Please put the same password' : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => confirmPassword = val);
                  }),

              //Choose between creative and sponsor
              Row(
                children: [
                  const Text("Creative"),
                  Switch(
                    // This bool value toggles the switch.
                    value: choose,
                    activeColor: Colors.red,
                    onChanged: (bool value) {
                      // This is called when the user toggles the switch.
                      setState(() {
                        choose = value;
                      });
                    },
                  ),
                  const Text("Sponsor"),
                ],
              ),

              //Register button
              const SizedBox(height: 20.0),
              ElevatedButton(
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          email, password, choose);
                      if (result == null) {
                        setState(() => error = 'please supply a valid email');
                      }
                    }
                  }),

              //Error text field. Emmpty be default
              const SizedBox(height: 12.0),
              Text(
                error,
                style: const TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ])),
      ),
    );
  }
}
