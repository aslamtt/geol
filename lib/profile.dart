import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geol/features/auth/screens/login.dart';
import 'package:geol/features/auth/screens/singup.dart';
import 'package:geol/features/auth/screens/splash.dart';

import 'main.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  bool on=true;
  bool of=false;
  List productList = [
    {
      "text": "Owner Details",
      "icon": Icons.accessibility,

    },

    {
      "text": "Financial Details",
      "icon": Icons.food_bank_outlined,
    },
    {
      "text": "Past Payment Transaction",
      "icon":Icons.payment,
    },
    {
      "text": "Help Center",
      "icon":Icons.help_center,
    },
    {
      "text": "Privacy And Policy",
      "icon": Icons.privacy_tip,
    },
    {"text": "FAQ",
      "icon": Icons.face
    },
    {
      "text": "Delete Account",
      "icon": Icons.delete,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children:[ Container(
                    height: h*0.25,
                    width: w*1.1,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade300,
                      borderRadius: BorderRadius.circular(9),
                      
                      // image: DecorationImage(image: AssetImage("assets/biriyani.jpeg"))
                    ),
                    child: Icon(Icons.fastfood_sharp,color: Colors.pink,size: 70,),
                  ),
                    Positioned(child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.edit),
                    ),
                    right: 10,
                      top: 5,
                    )
               ]),
              ),
              Text("Aslam's Kitchen",style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("GZM1223",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                     color: Colors.pink
                    ),
                  ),
                  Text("Alshifa Hospital Road....",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)
                ],
              ),
              SizedBox(height: 20,),
              Text("Documents Are UnderVerification",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
              Row(
                children: [
                  SizedBox(width: 100,),
                  Padding(
                    padding: EdgeInsets.all(h*0.005),
                    child: InkWell(
                      onTap: () {
                        on=true;
                        of=false;
                        setState(() {

                        });
                      },
                      child: Container(
                        height: h * 0.05,
                        width: w * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:on?Colors.pink:Colors.white,
                        ),
                        child: Center(child: Text("Online",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)),

                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.all(h*0.005),
                    child: InkWell(
                      onTap: () {
                        on=false;
                        of=true;
                        setState(() {

                        });
                      },
                      child: Container(
                        height: h * 0.05,
                        width: w * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: of?Colors.pink:Colors.white,
                        ),
                        child: Center(child: Text("Offline",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)),

                      ),
                    ),
                  ),

                ],
              ),
              Text("You Are Online"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: h * 0.07,
                      width: Checkbox.width * 0.9,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              bottom: BorderSide(
                                  width: 0.3, color: Color(0XFFC4C4C4)))),
                      child: ListTile(
                        minLeadingWidth: w * 0.14,
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: h * 0.018,
                          color: Colors.grey,
                        ),
                        leading: Container(
                          padding: const EdgeInsets.all(5),
                          height: h * 0.04,
                          width: w * 0.09,
                          decoration: BoxDecoration(
                              color: const Color(0xffFFFFFF),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xffF2F2F2),
                                  blurRadius: 15,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(7)),
                          child: Center(
                            child: Icon(productList[index]["icon"]
                            ),
                          ),
                        ),
                        title: Text(
                          productList[index]["text"],
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: h * 0.018),
                        ),
                      ),
                    );
                    //   Container(
                    //   height: 50,
                    //   width: double.infinity,
                    //   margin: EdgeInsets.only(bottom: 10),
                    //   decoration: BoxDecoration(
                    //     color: Colors.grey.shade400,
                    //     borderRadius: BorderRadius.circular(5),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       SizedBox(width: 15,),
                    //       Icon(productList[index]["icon"]),
                    //       SizedBox(width: 45,),
                    //       Text(productList[index]["text"]),
                    //       SizedBox(width: 175,),
                    //       Icon(Icons.arrow_forward_ios)
                    //
                    //     ],
                    //   ),
                    //
                    //
                    // );
                  },

                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink
                ),
                  onPressed: () {

              }, child:Text("Switch To Customer App",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
              SizedBox(height: 20,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink
                  ),
                  onPressed: () {
                     FirebaseFirestore.instance.collection("Users").doc(currentUserId).delete();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Signup(),), (route) => false);

                  }, child:Text("LogOut",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),


              

            ],
          ),
        ),
      ),
    );
  }
}
