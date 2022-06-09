import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pa_3/api/request/auth_request.dart';
import 'package:pa_3/api/response/auth_response.dart';
import 'package:pa_3/api/rest_client.dart';
import 'package:pa_3/constans/general_router_constant.dart';
import 'package:pa_3/constans/preferences.dart';
import 'package:pa_3/constans/role.dart';
import 'package:pa_3/utils/view_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool isLoading = false;
  bool editable = true;
  Map<String, String?> formValidate = {"password": null, "email": null};

  Future<dynamic> _login() async {
    var data = {'email': email, 'password': password};
    print(data);
    Dio dio = Dio();
    // dio.options.headers[]
    final client = RestClient(dio);
    setState(() {
      editable = false;
      isLoading = true;
    });
    try {
      AuthRequest request = AuthRequest(email: email!, password: password!);
      AuthResponse response = await client.login(request);
      ViewModels.ctrlState.sink.add([
        {"name": "user", "value": response.data},
        {"name": "token", "value": response.token},
        {"name": "refresh", "value": response.refresh}
      ]);
      final prefs = await SharedPreferences.getInstance();
      String convert = jsonEncode(response.data!);

      await prefs.setString(prefUser, convert);
      await prefs.setString(prefRefresh, response.refresh!);
      await prefs.setString(prefToken, response.token);
      setState(() {
        editable = true;
        isLoading = false;
        formValidate["email"] = null;
        formValidate["password"] = null;

        if (response.data!.role == roleAdmin) {
          Navigator.pushReplacementNamed(context, routeAdmin);
        }
      });
    } on DioError catch (e) {
      String? errorPass;
      String? errorEmail;
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          errorPass = "Password salah";
        }
        if (e.response!.statusCode == 404) {
          errorEmail = "Email tidak ditemukan";
        }
      }
      setState(() {
        isLoading = false;
        editable = true;
        formValidate["email"] = errorEmail;
        formValidate["password"] = errorPass;
        _formKey.currentState!.validate();
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
        editable = true;
        _formKey.currentState!.validate();
      });
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
                        enabled: editable,
                        onChanged: (data) {
                          if (formValidate["email"] != null) {
                            setState(() {
                              formValidate["email"] = null;
                              _formKey.currentState!.validate();
                            });
                          }
                        },
                        validator: (String? emailValue) {
                          if (emailValue!.isEmpty) {
                            return 'Enter your email';
                          }
                          if (formValidate["email"] != null) {
                            return formValidate["email"];
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
                        enabled: editable,
                        onChanged: (data) {
                          if (formValidate["password"] != null) {
                            setState(() {
                              formValidate["password"] = null;
                              _formKey.currentState!.validate();
                            });
                          }
                        },
                        obscureText: !_passwordVisible,
                        validator: (String? passwordValue) {
                          if (passwordValue!.isEmpty) {
                            return 'Enter your password';
                          }
                          if (formValidate["password"] != null) {
                            return formValidate["password"];
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
                            if (_formKey.currentState!.validate() &&
                                !isLoading) {
                              _login();
                            }
                          },
                          child: isLoading
                              ? CircularProgressIndicator()
                              : const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
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
