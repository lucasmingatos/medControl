import 'package:flutter/material.dart';

Drawer getHomeDrawer() {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: const [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Color(0xff0A6D92)),
          accountName: Text('usuário'),
          accountEmail: Text("email do usuário"),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
              "U",
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            color: Color(0xff0A6D92),
          ),
          title: Text("Configurações"),
        ),
        ListTile(
          leading: Icon(
            Icons.arrow_back,
            color: Color(0xff0A6D92),
          ),
          title: Text("Sair"),
          
        ),
      ],
    ),
  );
}
