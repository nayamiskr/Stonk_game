import 'package:flutter/material.dart';
import 'package:stonk_app/components/textinput.dart';
import 'package:stonk_app/page/HomePage.dart';

class LoginPage extends StatelessWidget {
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key});

  final String account = "hello";
  final String password = "123123";

  void login(BuildContext context) {
    if (userController.text == account && passwordController.text == password) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Wrong Account or Password")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(235, 2, 199, 254),
      body: Column(
        children: [
          const SizedBox(height: 200),
          //icon
          const Icon(
            Icons.account_circle,
            size: 150,
          ),
          //user name
          TextInput(
            controller: userController,
            hintText: 'Username',
            obscureText: false,
          ),
          const SizedBox(
            height: 15,
          ),
          //password
          TextInput(
            controller: passwordController,
            hintText: 'Password',
            obscureText: true,
          ),
          const SizedBox(
            height: 30,
          ),
          //sign in button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    login(context);
                  },
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(218, 3, 121, 255),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                          child: Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )))),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(218, 3, 121, 255),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                      child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
                ),
              )
            ],
          ),

          const SizedBox(
            height: 10,
          ),
          //register
        ],
      ),
    );
  }
}
