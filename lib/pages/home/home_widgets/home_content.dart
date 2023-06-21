import 'package:flutter/material.dart';

import '../../../shared/values/custom_colors.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({key}) : super(key: key);

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            CustomColors().getGradientMainColor(),
            CustomColors().getGradientSecColor(),
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 20,
      ),
      child: ListView(
        children: [
          ListTile(
            selected: false,
            tileColor: Colors.blue[100],
            leading: const ImageIcon(
              AssetImage('assets/icons/cancer.png'),
              size: 90,
              color: Colors.white,
            ),
            title: const Text(
              'Câncer',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            subtitle: const Text(
              'Medicações para tratamento do câncer',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/cancer');
            },
            hoverColor: Colors.blue,
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  CustomColors().getGradientMainColor(),
                  CustomColors().getGradientSecColor(),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
          ),
          ListTile(
            selected: false,
            tileColor: Colors.blue[100],
            leading: const ImageIcon(
              AssetImage('assets/icons/diabetes.png'),
              size: 90,
              color: Colors.white,
            ),
            title: const Text(
              'Diabetes',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            subtitle: const Text(
              'Medicações para tratamento do diabetes',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/diabetes');
            },
            hoverColor: Colors.blue,
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  CustomColors().getGradientMainColor(),
                  CustomColors().getGradientSecColor(),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
          ),
          ListTile(
            selected: false,
            tileColor: Colors.blue[100],
            leading: const ImageIcon(
              AssetImage('assets/icons/hipertensao.png'),
              size: 90,
              color: Colors.white,
            ),
            title: const Text(
              'Cardiovascular',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            subtitle: const Text(
              'Medicações para tratamento de doenças cardiovasculares',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/cardio');
            },
            hoverColor: Colors.blue,
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  CustomColors().getGradientMainColor(),
                  CustomColors().getGradientSecColor(),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
          ),
          ListTile(
            selected: false,
            tileColor: Colors.blue[100],
            leading: const ImageIcon(
              AssetImage('assets/icons/respiratoria.png'),
              size: 90,
              color: Colors.white,
            ),
            title: const Text(
              'Respiratórias',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            subtitle: const Text(
              'Medicações para tratamento de doenças respiratórias',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/resp');
            },
            hoverColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
