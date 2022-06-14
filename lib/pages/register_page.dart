import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pa_3/api/request/auth_request.dart';
import 'package:pa_3/api/response/auth_response.dart';
import 'package:pa_3/api/rest_client.dart';
import 'package:pa_3/constans/general_router_constant.dart';
import 'package:pa_3/utils/user_utils.dart';

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
  late String? name;
  late String? email;
  late String? phone;
  late String? address;
  late String? password;
  late String? confirmPassword;
  bool isLoading = false;
  bool editable = true;

  Future<dynamic> _register() async {
    AuthRequest request = AuthRequest(
        email: email!,
        password: password!,
        name: name,
        address: address,
        phoneNumber: phone,
        role: "Consumer");
    Dio dio = Dio();
    // dio.options.headers[]
    final client = RestClient(dio);
    setState(() {
      editable = false;
      isLoading = true;
    });
    try {
      AuthResponse response = await client.register(request);
      setupUserData(response);
      setState(() {
        editable = true;
        isLoading = false;
        formValidate["email"] = null;
        formValidate["password"] = null;

        redirectByRole(response.data!, context);
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

  Map<String, String?> formValidate = {
    "password": null,
    "email": null,
    "confirm_password": null,
    "phone_number": null,
    "address": null,
    "name": null
  };
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
                        validator: (String? nameValue) {
                          if (nameValue!.isEmpty) {
                            return 'Enter your Name';
                          }
                          name = nameValue;
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Name',
                          hintStyle: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Enter your phone number';
                          }
                          phone = value;
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Phone Number',
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
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Enter your address';
                          }
                          address = value;
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Address',
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
                          child: isLoading
                              ? CircularProgressIndicator()
                              : const Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
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
