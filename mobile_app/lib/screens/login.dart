import 'package:flutter/material.dart';
import 'package:mobile_app/screens/register.dart';
import 'package:mobile_app/utils/api.dart';
import 'package:mobile_app/widgets/button.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final formKey = GlobalKey<FormState>();
  String? email = "";
  String? password = "";
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
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text("Email / Username"),
                            hintText: "Enter your email or username"),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (newValue) => email = newValue,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                            label: Text("Password"),
                            hintText: "Enter your password"),
                        keyboardType: TextInputType.text,
                        onSaved: (newValue) => password = newValue,
                      ),
                    ],
                  )),
              const SizedBox(height: 12),
              Button(
                  text: "Login",
                  onPress: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                    }
                    await login(context, email, password);
                  }),
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
