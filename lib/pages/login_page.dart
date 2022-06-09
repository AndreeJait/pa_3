import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pa_3/api/request/auth_request.dart';
import 'package:pa_3/api/response/auth_response.dart';
import 'package:pa_3/api/rest_client.dart';
import 'package:pa_3/constans/general_router_constant.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late String? email;
  late String? password;

  Future<dynamic> _login() async {
    var data = {'email': email, 'password': password};
    print(data);
    Dio dio = Dio();
    // dio.options.headers[]
    final client = RestClient(dio);
    try {
      AuthRequest request = AuthRequest(email: email!, password: password!);
      AuthResponse response = await client.login(request);
      print(response);
    } catch (e) {
      print(e);
    }
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
                top: 50,
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
                        "Login",
                        style: TextStyle(
                            color: Color(0xff585858),
                            fontWeight: FontWeight.w400,
                            fontSize: 20),
                      ),
                    ),
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
                              _login();
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Create your account'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, routeRegister);
                          },
                          child: const Text('here'),
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
