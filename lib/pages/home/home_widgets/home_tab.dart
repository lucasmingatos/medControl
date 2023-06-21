import 'package:flutter/material.dart';
import 'package:tcc/pages/home/tips_pages/tips_page.dart';
import '../home_page.dart';
import 'alarm/alarm_page.dart';

class HomeTabBar extends StatelessWidget {
  final String id;
  const HomeTabBar(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Med Control'),
          backgroundColor: const Color(0xff0A6D92),
          automaticallyImplyLeading: false,
          centerTitle: true,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Página inicial',
                icon: Icon(
                  Icons.home_rounded,
                  color: Colors.white,
                ),
              ),
              Tab(
                text: 'Alertas',
                icon: Icon(
                  Icons.timer_sharp,
                  color: Colors.white,
                ),
              ),
              Tab(
                text: 'Dicas',
                icon: Icon(
                  Icons.lightbulb,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [
          HomePage(dynamic),
          AlarmPage(),
          TipsPage(),
        ]),
      ),
    );
  }
}
