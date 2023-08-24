import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:todo/provider/firebase_auth_provider.dart';
import 'package:todo/view/home_view.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView>
    with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    if (!emailController.text.trim().isEmail) return;
    if (passwordController.text.trim().length < 4) return;
    final List<String> list = [
      emailController.text.trim(),
      passwordController.text.trim()
    ];
    ref
        .read(loginUserProvider(list))
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeView())))
        .catchError((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Invalid Credentials')));
    });
  }

  void register() {
    if (!emailController.text.trim().isEmail) return;
    if (passwordController.text.trim().length < 4) return;
    final List<String> list = [
      emailController.text.trim(),
      passwordController.text.trim()
    ];
    ref
        .read(registerUserProvider(list))
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeView())))
        .catchError((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Invalid Credentials')));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
            child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                ),
                12.height,
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                ),
                48.height,
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => login(),
                    child: const Text("Log In"),
                  ),
                ),
                24.height,
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => register(),
                    child: const Text("Sign In"),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
