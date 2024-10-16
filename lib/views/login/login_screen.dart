import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sea/constants/password_textfield.dart';
import 'package:sea/views/navigation.dart';

import '../../constants/colors.dart';
import '../../constants/custom_button.dart';
import '../../constants/custom_textfield.dart';
import '../signup/signup_screen.dart';
import 'login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
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
  Provider.of<LoginProvider>(context, listen: false).clearFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    print('Rebuild');
    return Scaffold(
      backgroundColor: Colours.kScaffoldColor,
      body: Consumer<LoginProvider>(
        builder: (context, vm, child) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/2.png', color: Colours.kGreenColor, height: heightX * 0.3,),
                  Text(
                    'Let\'s get you Login!',
                    style: TextStyle(
                        fontSize: heightX * 0.04, fontWeight: FontWeight.bold, color: Colours.kGreenColor),
                  ),
                  Text(
                    'Enter your information below',
                    style: TextStyle(
                        fontSize: heightX * 0.02, fontWeight: FontWeight.bold, color:  Colors.white),
                  ),
                  SizedBox(
                    height: heightX * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      suffix: Icon(Icons.email_outlined,color: Colors.grey,),
                        controller: vm.emailController,
                        hintText: 'Enter Email',
                          read: false, onPress: () {  },),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PasswordTextField(controller: vm.passwordController,),
                  ),
                  SizedBox(
                    height: heightX * 0.02,
                  ),
                  CustomButton(
                      btnHeight: heightX * 0.06,
                      btnWidth: widthX * 0.95,
                      btnText: 'Login',

                      onPress: () async{
                        try {
                          String? validation = loginProvider.validation();
                          if (validation != null){
                            showSnackBar(validation);
                          }
                          else {
                            String? error = await loginProvider.login();
                            if(error == null){
                              showSnackBar('Account Login Successfully');
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Navigation()));
                            }
                            else {
                              showSnackBar(error);
                            }
                          }
                        }
                        catch (e){
                          showSnackBar(
                              'An unexpected error occurred. Please try again.');
                          debugPrint(e as String?) ;
                        }

                      },
                  ),
                  SizedBox(
                    height: heightX * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
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
                                  builder: (context) => const SignupScreen()));
                        },
                        child: Text(
                          'SignUp Now',
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