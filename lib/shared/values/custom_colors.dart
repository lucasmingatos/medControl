import 'package:flutter/material.dart';

class CustomColors {
  final Color _activePrimaryButton = const Color.fromARGB(255, 63, 81, 181);
  final Color _activeSecondaryButton = const Color.fromARGB(255, 255, 255, 255);
  final Color _gradientMainColor = const Color.fromARGB(255, 0, 75, 200);
  final Color _gradientSecColor = const Color.fromARGB(255, 75, 175, 255);
  final Color _appBarMainColor = const Color(0xff0A6D92);

  Color getActivePrimaryButtonColor() {
    return _activePrimaryButton;
  }

  Color getActiveSecondaryButtonColor() {
    return _activeSecondaryButton;
  }

  Color getGradientMainColor() {
    return _gradientMainColor;
  }

  Color getGradientSecColor() {
    return _gradientSecColor;
  }

  Color getAppBarMainColor() {
    return _appBarMainColor;
  }
}
