import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sea/constants/colors.dart';
import 'package:sea/constants/password_textfield.dart';
import 'package:sea/views/signup/signup_provider.dart';

import '../../constants/custom_button.dart';
import '../../constants/custom_textfield.dart';
import '../login/login_screen.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colours.kGreenColor,
        // action: SnackBarAction(
        //     label: 'Cancel', textColor: Colors.white, onPressed: () {}),
      ),
    );
  }

  @override
  void initState() {
   Provider.of<SignupProvider>(context, listen: false).clearFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    // final signupProvider = Provider.of<SignupProvider>(context);
    return Scaffold(
      backgroundColor: Colours.kScaffoldColor,
      body: Consumer<SignupProvider>(
        builder: (context, vm, child) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/3.png',

                     color: Colours.kGreenColor,
                    height: heightX * 0.2,
                  ),
                  SizedBox(
                    height: heightX * 0.03,
                  ),
                  Text(
                    'Welcome! Signup now',
                    style: TextStyle(
                        fontSize: heightX * 0.04,
                        fontWeight: FontWeight.bold,
                        color: Colours.kGreenColor),
                  ),
                  Text(
                    'Enter your information below',
                    style: TextStyle(
                        fontSize: heightX * 0.02,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: heightX * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      suffix: Icon(Icons.account_circle, color: Colors.grey,),
                        controller: vm.nameController,
                        hintText: 'Enter Name',
                          read: false, onPress: () {  },),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      suffix: Icon(Icons.email_outlined, color: Colors.grey,),
                        controller: vm.emailController,
                        hintText: 'Enter Email', read: false, onPress: () {  },
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      suffix: Icon(Icons.phone, color: Colors.grey,),
                      keyboardType: TextInputType.number,
                        controller: vm.phoneNoController,
                        hintText: 'Enter Phone No',
                        read: false, onPress: () {  },),
                  ),

                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: PasswordTextField(controller: vm.passwordController),
                 ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                        onPress: () async {
                          try {
                            String? validation = vm.validation();
                            if(validation != null){
                              showSnackBar(validation);
                            }

                            else {
                              String? error = await vm.signUp();
                              if (error == null) {
                                showSnackBar('Account Created Successfully');
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoginScreen()));
                              }
                              else {
                                showSnackBar(error);
                              }
                            }
                          } catch (e) {
                            showSnackBar(
                                'An unexpected error occurred. Please try again.');

                            //debugPrint(e as String?) ;
                          }
                        }, btnText: 'Sign Up', btnHeight: heightX * 0.06, btnWidth: widthX * 0.95,

                    ),
                  ),
                  SizedBox(
                    height: heightX * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          fontSize: heightX * 0.02,
                          color: Colors.white
                        ),
                      ),
                      SizedBox(
                        width: widthX * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: Text(
                          'Login Now',
                          style: TextStyle(
                              color: Colours.kGreenColor,
                              fontSize: heightX * 0.02,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}