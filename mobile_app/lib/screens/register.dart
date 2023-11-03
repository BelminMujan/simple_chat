import 'package:flutter/material.dart';
import 'package:mobile_app/utils/api.dart';
import 'package:mobile_app/widgets/button.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  final formKey = GlobalKey<FormState>();
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
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration:
                          const InputDecoration(label: const Text("Email")),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      decoration:
                          const InputDecoration(label: const Text("Username")),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      obscureText: true,
                      decoration:
                          const InputDecoration(label: const Text("Password")),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                          label: const Text("Password confirm")),
                      keyboardType: TextInputType.text,
                    ),
                  ],
                )),
            const SizedBox(height: 12),
            Button(
                text: "Register",
                onPress: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
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
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => const Login()));
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
