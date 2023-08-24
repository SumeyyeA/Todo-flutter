import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:todo/provider/firebase_auth_provider.dart';
import 'package:todo/view/home_view.dart';
import 'package:todo/view/login_view.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  void _init() {
    final user = ref.read(currentUserProvider);
    Future.delayed(500.milliseconds, () {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeView()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginView()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
