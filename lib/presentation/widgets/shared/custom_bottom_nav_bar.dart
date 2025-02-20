import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget{
  const CustomBottomNavBar ({super.key});


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home Screen'),
          BottomNavigationBarItem(
          icon: Icon(Icons.label_outlined),
          label: 'Categories'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Favorites')
      ]);
  }}