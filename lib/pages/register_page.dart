import 'package:flutter/material.dart';
import 'package:pa_3/constans/general_router_constant.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _passwordVisible = false;
  var _confirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late String? username;
  late String? email;
  late String? phone;
  late String? password;
  late String? confirmPassword;

  Future<dynamic> _register() async {
    var data = {
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
      'confirmPassword': confirmPassword,
    };
    try {} catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: Image.asset(
                "assets/images/chemil.png",
                height: 120,
                width: 120,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 30,
                right: 30,
                left: 30,
              ),
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, right: 20, left: 20),
              decoration: BoxDecoration(
                color: const Color(0xffEFEEEE),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Form(
                key: _formKey,
                child: Wrap(
                  spacing: 20,
                  runSpacing: 5,
                  alignment: WrapAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            color: Color(0xff585858),
                            fontWeight: FontWeight.w400,
                            fontSize: 20),
                      ),
                    ),
                    // Username
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        validator: (String? usernameValue) {
                          if (usernameValue!.isEmpty) {
                            return 'Enter your username';
                          }
                          username = usernameValue;
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Username',
                          hintStyle: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                    // Email
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        validator: (String? emailValue) {
                          if (emailValue!.isEmpty) {
                            return 'Enter your email';
                          }
                          email = emailValue;
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                    // Password
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: !_passwordVisible,
                        validator: (String? passwordValue) {
                          if (passwordValue!.isEmpty) {
                            return 'Enter your password';
                          }
                          password = passwordValue;
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.black54),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ))),
                      ),
                    ),
                    // Confirm Password
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: !_confirmPasswordVisible,
                        validator: (String? confirmPasswordValue) {
                          if (confirmPasswordValue!.isEmpty) {
                            return 'Enter your confirm password';
                          }
                          confirmPassword = confirmPasswordValue;
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle: const TextStyle(color: Colors.black54),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _confirmPasswordVisible =
                                        !_confirmPasswordVisible;
                                  });
                                },
                                icon: Icon(
                                  _confirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ))),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: const Color(0xffF8C83F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _register();
                            }
                          },
                          child: const Text(
                            'REGISTER',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, routeLogin);
                          },
                          child: const Text('Login'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
