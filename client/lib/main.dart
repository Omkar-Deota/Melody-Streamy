import 'package:client/core/theme/theme.dart';
import 'package:client/features/auth/view/pages/login_view.dart';
import 'package:client/features/auth/view/pages/signup_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      home: const LoginView(),
    );
  }
}
