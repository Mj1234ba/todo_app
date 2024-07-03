import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/register_screen.dart';
import 'package:todo_app/auth/user_provider.dart';
import 'package:todo_app/fire_base_utils.dart';
import 'package:todo_app/home_screen.dart';
import 'package:todo_app/tabs/tasks/default_elevated_button.dart';
import 'package:todo_app/tabs/tasks/default_form_field.dart';
import 'package:todo_app/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Text(
              'Login',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 20, color: AppTheme.white),
            )),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'asset/images/background.png',
                  ),
                  fit: BoxFit.cover)),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 16,
                ),
                DefaultTextFtromField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email can not be empty';
                      }
                      return null;
                    },
                    label: 'emial',
                    textEditingController: emailController),
                const SizedBox(
                  height: 16,
                ),
                DefaultTextFtromField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password can not be empty';
                    } else if (value.length < 6) {
                      return 'Should be at least 6 characters';
                    }
                    return null;
                  },
                  label: 'Password',
                  textEditingController: passwordController,
                  isPassword: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                DefaultElevtedButton(
                    onpress: () {login();},
                    child: Row(
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: AppTheme.white, fontSize: 14),
                        ),
                        const Spacer(
                          flex: 10,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: AppTheme.white,
                        ),
                        const Spacer(
                          flex: 1,
                        )
                      ],
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(RegisterScreen.registerroute);
                    },
                    child: Text(
                      'Or Create My Account ',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w300),
                    ))
              ],
            ),
          ),
        ));
  }

  void login() {
    if (formKey.currentState?.validate() == true) {
      FirebaseUtils.login(emailController.text, passwordController.text).then((user) {
        print('name is ${emailController.text}');

        print('password is ${passwordController.text}');
        Provider.of<UserProvider>(context,listen: false).updateUser(user);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }).catchError((error) {
        if (error is FirebaseAuthException && error.message != null) {
          Fluttertoast.showToast(
              msg: error.message!, toastLength: Toast.LENGTH_LONG);
        } else {
          Fluttertoast.showToast(
              msg: 'SomeThing went Wrong ', toastLength: Toast.LENGTH_LONG);
        }
      });
    }
  }
}
