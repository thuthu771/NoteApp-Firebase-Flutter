import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_noteapp/homepage.dart';
//import 'package:firebase_noteapp/homepage.dart';
import 'package:firebase_noteapp/signup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  final fireauth = FirebaseAuth.instance;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController pwcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void loginUser() async {
    try {
      fireauth.signInWithEmailAndPassword(
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
      body: SingleChildScrollView(
        child: Form(
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
                          "Sign in",
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
                    decoration: const InputDecoration(
                        hintText: "enter your email id:",
                        suffixIcon: Icon(Icons.email)),
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
                    decoration: const InputDecoration(
                        hintText: "enter your password:",
                        suffixIcon: Icon(Icons.lock_outline_rounded)),
                  ),
                ),
              ),
              // SizedBox(height: 5),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 30,
                  width: 150,
                  decoration: BoxDecoration(
                      //color: Color.fromARGB(255, 245, 240, 240),
                      borderRadius: BorderRadiusDirectional.circular(10)),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Forgot passsword?",
                    ),
                  ),
                ),
              ),
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
                      child: InkWell(
                        onTap: () {
                          loginUser();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage()));
                        },
                        child: const Text(
                          "login",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      )),
                ),
              ),

              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  children: [
                    const Text("Don't have an account?"),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignUp()));
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
