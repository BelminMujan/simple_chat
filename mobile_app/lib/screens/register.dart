import 'package:flutter/material.dart';
import 'package:mobile_app/utils/api.dart';
import 'package:mobile_app/widgets/button.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  final registerKey = GlobalKey<FormState>();
  String? email;
  String? username;
  String? password;
  String? passwordConfirm;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat app register")),
      body: Container(
        padding: const EdgeInsets.fromLTRB(45, 150, 45, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: registerKey,
                child: Column(
                  children: [
                    TextFormField(
                      autocorrect: false,
                      decoration:
                          const InputDecoration(label: const Text("Email")),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (newValue) => email = newValue,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      autocorrect: false,
                      decoration:
                          const InputDecoration(label: const Text("Username")),
                      keyboardType: TextInputType.text,
                      onSaved: (newValue) => username = newValue,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      autocorrect: false,
                      obscureText: true,
                      decoration:
                          const InputDecoration(label: const Text("Password")),
                      keyboardType: TextInputType.text,
                      onSaved: (newValue) => password = newValue,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      autocorrect: false,
                      obscureText: true,
                      decoration: const InputDecoration(
                          label: const Text("Password confirm")),
                      keyboardType: TextInputType.text,
                      onSaved: (newValue) => passwordConfirm = newValue,
                    ),
                  ],
                )),
            const SizedBox(height: 12),
            Button(
                text: "Register",
                onPress: () async {
                  if (registerKey.currentState!.validate()) {
                    registerKey.currentState!.save();
                  }
                  await register(
                      context, email, username, password, passwordConfirm);
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Log in",
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
