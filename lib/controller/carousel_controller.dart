import 'package:flutter/material.dart';

class carousel_controller {
  late PageController _pageController;
  List<String> images = [
    "assets/banners/banner_emergency.jpg",
    "assets/banners/online_mode.jpeg",
    "assets/banners/policebanners.jpg"
  ];

  carousel_controller() {
    _pageController = PageController();
  }

  PageController get pageController => _pageController;

  void dispose() {
    _pageController.dispose();
  }
}
