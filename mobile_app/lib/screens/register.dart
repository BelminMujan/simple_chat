import 'package:flutter/material.dart';
import 'package:mobile_app/screens/login.dart';
import 'package:mobile_app/widgets/button.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(45, 150, 45, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(label: const Text("Email")),
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
            Button(text: "Register", onPress: () => {}),
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
