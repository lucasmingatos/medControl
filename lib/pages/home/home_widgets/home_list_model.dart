//classe para definir os parâmetros do home list item
//icon
//titulo
//lixeirinha

import 'package:flutter/material.dart';

class HomeListModel {
  Icons? icon;
  String assetIcon;
  String title;

  HomeListModel({this.icon, required this.assetIcon, required this.title});
}
