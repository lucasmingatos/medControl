import 'package:flutter/material.dart';
import 'home_widgets/home_appbar.dart';
import 'home_widgets/home_content.dart';

class HomePage extends StatelessWidget {
  //const HomePage(dynamic uid, {dynamic key});
  const HomePage(dynamic uid, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getHomeAppBar(),
      body: const HomePageContent(),
    );
  }
}
