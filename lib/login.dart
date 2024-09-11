import 'package:adminsite/api_php.dart';
import 'package:adminsite/home.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return const FluentApp(
      debugShowCheckedModeBanner: false, 
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool isLoginForm = true; // Added to track the form to display
  TextEditingController loginUsernameController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  String l = ' FIlPEn Admin';

  final storage = const FlutterSecureStorage();

  Future<void> loginUser() async {
    try {
      final response = await http.post(
        Uri.parse(Api.login),
        body: {
          'username': loginUsernameController.text,
          'password': loginPasswordController.text,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          final token = data['token'];
          await storage.write(key: 'token', value: token);
          if (!context.mounted) return;
          Navigator.pushReplacement(
            context,
            FluentPageRoute(builder: (context) => Home(token: token)),
          );
        } else {
          final errorMessage = data['message'];
          if (!context.mounted) return;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return material.AlertDialog(
                title: const Text('Login Failed'),
                content: Text(errorMessage),
                actions: <Widget>[
                  material.TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        if (!context.mounted) return;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return material.AlertDialog(
              title: const Text('Server Error'),
              content: const Text('An error occurred while connecting to the server.'),
              actions: <Widget>[
                material.TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (err) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return material.AlertDialog(
            title: const Text('Error'),
            content: Text('An error occurred: $err'),
            actions: <Widget>[
              material.TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return material.Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 30, 69),
      body: SizedBox(
        height: double.maxFinite,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(alignment: Alignment.topCenter, child: title()),
              Container(
                width: 600,
                height: 400,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.white),
                  color: const Color.fromARGB(255, 22, 30, 69),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      child: Text(
                        l,
                        style: const TextStyle(color: Colors.white, fontSize: 30, fontFamily: "Kadwa"),
                      ),
                    ),
                    const SizedBox(height: 80),
                    Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 22, 42, 94),
                      ),
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                      alignment: Alignment.center,
                      child: material.TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: loginUsernameController,
                        decoration: const material.InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          border: material.InputBorder.none,
                          floatingLabelAlignment: material.FloatingLabelAlignment.start,
                          labelText: 'Username/Email',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 22, 42, 94),
                      ),
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                      alignment: Alignment.center,
                      child: material.TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: loginPasswordController,
                        decoration: const material.InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          border: material.InputBorder.none,
                          floatingLabelAlignment: material.FloatingLabelAlignment.start,
                          labelText: 'Password',
                        ),
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 2, color: Colors.white),
                      ),
                      child: material.ElevatedButton(
                        style: material.ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromARGB(255, 22, 42, 94), // Text color
                          elevation: 5, // Elevation (shadow)
                          padding: const EdgeInsets.all(16), // Button padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0), // Adjust the radius as needed
                          ),
                        ),
                        onPressed: loginUser,
                        child: const Text('Login'),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget title() {
  return SizedBox(
    height: 100,
    width: 300,
    child: Center(
      child: Column(
        children: const [
          SizedBox()
        ],
      ),
    ),
  );
}

class IndicatorWidget extends StatelessWidget {
  final Color indicatorColor;

  const IndicatorWidget({super.key, required this.indicatorColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: indicatorColor,
      ),
    );
  }
}
