import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geol/features/auth/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../nav.dart';
var currentUserId=FirebaseAuth.instance.currentUser?.uid;
String currentuserId="";
Map<String,dynamic>currentUserdata={};
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String?email;
  String?password;
  Future<void>checklogin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    email = pref.getString("email");
    password = pref.getString("password");
    Future.delayed(Duration(seconds: 3));
    if(currentUserId!=null){
      Navigator.push(context,MaterialPageRoute(builder: (context) =>navbar(),));
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 3)).then((value) => checklogin());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 250,),
            Center(child: Text("WELCOME",style: TextStyle(fontWeight: FontWeight.bold),)),
            Icon(Icons.location_on,color: Colors.pink,size: 220,)


          ],
        ),
      ),

    );
  }
}
