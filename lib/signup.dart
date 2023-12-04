import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_noteapp/loginscreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:login_page/backuppage.dart';
//import 'package:login_page/loginscreen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final fireauth = FirebaseAuth.instance;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController pwcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  void createuser() async {
    try {
      fireauth.createUserWithEmailAndPassword(
          email: emailcontroller.text, password: pwcontroller.text);
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    pwcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      // color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const SizedBox(
              height: 25,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  "email id:",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.green,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 70,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: emailcontroller,
                  validator: (value) {
                    final isValid = EmailValidator.validate(value.toString());
                    return isValid ? null : "Email is not valid!";
                  },
                  decoration:
                      const InputDecoration(hintText: "enter your email id:"),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 25,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  "password:",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.green,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 70,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: pwcontroller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "password is required";
                    }
                    if (value.length < 8) {
                      return "password must be atleast 8 characters long";
                    }
                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      return "Password must contain at least one uppercase letter";
                    }
                    if (!value.contains(RegExp(r'[a-z]'))) {
                      return "Password must contain at least one lowercase letter";
                    }
                    if (!value.contains(RegExp(r'[0-9]'))) {
                      return "Password must contain at least one numeric character";
                    }
                    if (!value.contains(RegExp(r'[!@#\$%^&*()<>?/|}{~:]'))) {
                      return "Password must contain at least one special character";
                    }

                    return null;
                  },
                  decoration:
                      const InputDecoration(hintText: "enter your password:"),
                ),
              ),
            ),
            // SizedBox(height: 5),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              createuser();
                            }
                          },
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                children: [
                  const Text("Already have an account, "),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LogScreen()));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 17),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
