import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/component/custom_button.dart';
import 'package:scholar_chat/component/custom_textfield.dart';
import 'package:scholar_chat/helper/show_snake_bar.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? userEmail, userPassword;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: const Color(0xff2B475E),
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
                      'LOGIN',
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
                  onTap: () async {
                    //and check for email  & password with firebase
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        // Method to log in user
                        await loginUser();
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: userEmail);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
                          showSnakeBar(context, 'Wrong Password or Email.');
                        }
                      } catch (e) {
                        showSnakeBar(context, 'Error');
                      }
                      // if no error it show snake bar for success
                      isLoading = false;
                      setState(() {});
                    }
                  },
                  customText: 'Login',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have account?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: Text(
                          ' SignUp',
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

  Future<void> loginUser() async {
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: userEmail!,
      password: userPassword!,
    );
  }
}
