import 'package:flutter/material.dart';
import 'package:mobile_app/screens/register.dart';
import 'package:mobile_app/widgets/button.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("App bar")),
        body: Container(
          padding: const EdgeInsets.fromLTRB(45, 150, 45, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        label: const Text("Email / Username"),
                        hintText: "Enter your email or username"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                        label: const Text("Password"),
                        hintText: "Enter your password"),
                    keyboardType: TextInputType.text,
                  ),
                ],
              )),
              const SizedBox(height: 12),
              Button(text: "Login", onPress: () => {}),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()));
                    },
                    child: const Text(
                      "Create one",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
