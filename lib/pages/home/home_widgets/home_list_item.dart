// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:tcc/shared/values/custom_colors.dart';
import 'home_list_model.dart';

class HomeListItem extends StatefulWidget {
  final HomeListModel homeListModel;
  HomeListItem({required this.homeListModel});

  @override
  _HomeListItemState createState() => _HomeListItemState();
}

class _HomeListItemState extends State<HomeListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Container(
            height: 15,
            decoration: BoxDecoration(
              color: CustomColors().getAppBarMainColor(),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(7),
                topRight: Radius.circular(7),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(widget.homeListModel.assetIcon),
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                    ),
                    Text(
                      widget.homeListModel.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xff0A6D92),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
