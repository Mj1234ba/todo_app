import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/login_screen.dart';
import 'package:todo_app/auth/test_page.dart';
import 'package:todo_app/auth/user_provider.dart';
import 'package:todo_app/fire_base_utils.dart';
import 'package:todo_app/home_screen.dart';
import 'package:todo_app/tabs/tasks/default_elevated_button.dart';
import 'package:todo_app/tabs/tasks/default_form_field.dart';
import 'package:todo_app/theme.dart';

class RegisterScreen extends StatefulWidget {
  static String registerroute = '/register';
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();
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
              'Create Account',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 20, color: AppTheme.white),
            )),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          decoration: BoxDecoration(
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
                DefaultTextFtromField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name can not be empty';
                      }
                      return null;
                    },
                    textEditingController: nameController,
                    label: 'First Name'),
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
                    onpress: () {
                      register();
                    },
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
                          flex: 8,
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
                SizedBox(height: 16),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                    child: Text(
                      'Already have an Account',
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

  void register() {
    print('function Work @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    if (formKey.currentState?.validate() == true) {
      
      FirebaseUtils.register(
              password: passwordController.text,
              email: emailController.text,
              name: nameController.text)
          .then((user) {
            print('we uinsidddddd****************************************');
        Provider.of<UserProvider>(context, listen: false).updateUser(user);
       //  Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TestPage())); 
      }).catchError((error) {
        if (error is FirebaseAuthException && error.message == null) {
          Fluttertoast.showToast(
              msg: error.message!, toastLength: Toast.LENGTH_LONG);
        } else {
          Fluttertoast.showToast(
              msg: 'Something went Wrong======== $error', toastLength: Toast.LENGTH_LONG);
        }
      });
     
      //  Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }
}
