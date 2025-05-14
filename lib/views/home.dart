import 'package:flutter/material.dart';
import 'package:hometender/widgets/app_text.dart';
import 'package:hometender/widgets/app_text_field.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                AppTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                ),
                AppText.caption('Home Tender'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
