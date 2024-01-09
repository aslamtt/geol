import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:geol/features/auth/screens/login.dart';
import 'package:geol/pages/oder.dart';
// import 'package:geol/pages/home.dart';
// import 'package:geol/pages/oder.dart';
import 'package:geol/features/product/screens/product.dart';
// import 'package:geol/pages/profile.dart';
import 'package:geol/profile.dart';

import 'Home.dart';
// import 'order/screens/oder.dart';

class navbar extends StatefulWidget {
  const navbar({Key? key}) : super(key: key);

  @override
  State<navbar> createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  final iteams = [
     Icon(Icons.home,size: 20,color: Colors.pink,),
    Icon(Icons.shopping_cart,size: 20,color: Colors.pink,),
     Icon(Icons.category,size: 20,color: Colors.pink,),
     Icon(Icons.settings,size: 20,color: Colors.pink,),
   ];
  final screen= [
    MyHomePage(),
    oder(),
    productpage(),
    Profile()
    // Login()
  ];
  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[index],
      bottomNavigationBar: CurvedNavigationBar(
          items: iteams,
        index: index,
        backgroundColor: Colors.black,
        onTap: (index) => setState(() {
          this.index = index;
        })


      ),
    );
  }
}
