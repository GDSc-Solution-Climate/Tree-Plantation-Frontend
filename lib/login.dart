import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tree_plantation_frontend/bottom_nav_bar.dart';
import 'package:tree_plantation_frontend/services/user_services.dart';

String userName = "";
String userId = "";

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isLoginScreen = true;
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: h,
          width: w,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 1),
              colors: <Color>[
                Color(0xff1f005c),
                Color(0xff5b0060),
                Color(0xff870160),
                Color(0xffac255e),
                Color(0xffca485c),
                Color(0xffe16b5c),
                Color(0xfff39060),
                Color(0xffffb56b),
              ],
              tileMode: TileMode.mirror,
            ),
          ),
          padding: EdgeInsets.only(
            top: h * 0.05,
            bottom: h * 0.05,
            left: w * 0.03,
            right: w * 0.03,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.account_circle,
                  size: w * 0.3,
                  color: Colors.white,
                ),
                SizedBox(
                  height: w * 0.04,
                ),
                AutoSizeText(
                  isLoginScreen ? 'Welcome Back!' : 'Create an Account',
                  minFontSize: 30,
                  maxFontSize: 40,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway', // Custom font, if available
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: h * 0.03),
                TextFormField(
                  controller: _userName,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'User Name',
                    prefixIcon:
                        Icon(Icons.person_2_rounded, color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.03),
                isLoginScreen
                    ? Container()
                    : TextFormField(
                        controller: _email,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email, color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                SizedBox(height: h * 0.03),
                TextFormField(
                  controller: _password,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.05),
                ElevatedButton(
                  onPressed: () async {
                    if (isLoginScreen == true) {
                      if (_userName.text == "" || _password.text == "") {
                        Get.snackbar(
                          "Error",
                          "Please fill all the fields",
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(
                            seconds: 2,
                          ),
                        );
                      } else if (_password.text.length < 8) {
                        Get.snackbar(
                          "Error",
                          "Password must be atleast 8 characters long",
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(
                            seconds: 2,
                          ),
                        );
                      } else {
                        // Login user
                        var user = await UserServices.login(
                            _userName.text, _password.text);
                        if (user.containsKey('token')) {
                          var userData = Jwt.parseJwt(user["token"].toString());
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString("token", user["token"].toString());
                          print(userData);
                          userName = userData['username'];
                          userId = userData['userId'];
                          Get.snackbar(
                            "Success",
                            "Logged in successfully",
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(
                              seconds: 1,
                            ),
                          );
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MyNavigationBar()));
                        } else {
                          Get.snackbar(
                            "Error",
                            "Invalid username or password",
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(
                              seconds: 2,
                            ),
                          );
                        }
                      }
                    } else {
                      if (_userName.text == "" ||
                          _email.text == "" ||
                          _password.text == "") {
                        Get.snackbar(
                          "Error",
                          "Please fill all the fields",
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(
                            seconds: 2,
                          ),
                        );
                      } else if (_password.text.length < 8) {
                        Get.snackbar(
                          "Error",
                          "Password must be atleast 8 characters long",
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(
                            seconds: 2,
                          ),
                        );
                      } else if (_email.text.contains("@") == false) {
                        Get.snackbar(
                          "Error",
                          "Please enter a valid email",
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(
                            seconds: 2,
                          ),
                        );
                      } else if (isLoginScreen == false) {
                        // Create new user
                        var user = await UserServices.createUser(
                            _email.text, _password.text, _userName.text);
                        final prefs = await SharedPreferences.getInstance();
                        if (user != Error()) {
                          Get.snackbar(
                            "Success",
                            "User created successfully",
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(
                              seconds: 2,
                            ),
                          );
                          if (user.containsKey('token')) {
                            var userData =
                                Jwt.parseJwt(user["token"].toString());
                            prefs.setString("token", user["token"].toString());
                            print(userData);
                            userName = userData['username'];
                            userId = userData['userId'];
                          }

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const MyNavigationBar(),
                            ),
                          );
                        }
                      } else {
                        // Login user
                        var user = await UserServices.login(
                            _userName.text, _password.text);
                        if (user.containsKey('token')) {
                          // print(user["token"]);
                          // var userData = JwtDecoder.decode(user["token"]);
                          // print(userData);
                          Get.snackbar(
                            "Success",
                            "Logged in successfully",
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(
                              seconds: 1,
                            ),
                          );
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MyNavigationBar()));
                        } else {
                          Get.snackbar(
                            "Error",
                            "Invalid username or password",
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(
                              seconds: 2,
                            ),
                          );
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.white,
                  ),
                  child: Text(isLoginScreen ? 'Login' : 'Signup'),
                ),
                SizedBox(height: h * 0.02),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLoginScreen = !isLoginScreen;
                    });
                  },
                  child: AutoSizeText(
                    isLoginScreen
                        ? 'New user? Create an account'
                        : 'Already have an account? Log in',
                    minFontSize: 15,
                    maxFontSize: 25,
                    style: const TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      fontFamily: 'Raleway', // Custom font, if available
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
