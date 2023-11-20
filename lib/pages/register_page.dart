import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/component/custom_button.dart';
import 'package:scholar_chat/component/custom_textfield.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/helper/show_snake_bar.dart';

class RegisterPage extends StatefulWidget {
  static String id = 'registerPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? userEmail;

  String? userPassword;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 100,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'Pacifico',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 75,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  obscurePW: false,
                  hintText: 'Email',
                  onChanged: (data) {
                    userEmail = data;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  obscurePW: true,
                  hintText: 'Password',
                  onChanged: (data) {
                    userPassword = data;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  //button register
                  onTap: () async {
                    //and check for email  & password with firebase
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        //method to register-user
                        await registerUser();
                        showSnakeBar(context, 'Success');
                        //e for errors to handel
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnakeBar(context, 'weak-password');
                        } else if (e.code == 'email-already-in-use') {
                          showSnakeBar(context, 'email-already-in-use');
                        }
                      } catch (e) {
                        showSnakeBar(context, 'Error , Try again latter');
                      }

                      // if no error it show snakebar for success
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  customText: 'Register',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'have an account?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'LogIn',
                          style: TextStyle(
                            color: Colors.blueGrey[300],
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: userEmail!, password: userPassword!);
  }
}
