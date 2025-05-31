import 'package:flutter/material.dart';
import 'package:home_tender/utilities/components/ht_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: HTText(
          'Home Tender',
          variant: TextVariant.titleMedium,
        ),
      ),
    );
  }
}
