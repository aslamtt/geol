import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geol/Models/authModel.dart';
import 'package:geol/features/auth/controller/auth_controller.dart';
import 'package:geol/features/auth/screens/login.dart';

class Signup extends ConsumerStatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  ConsumerState<Signup> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
  bool eye=false;
  TextEditingController email_controller=TextEditingController();
  TextEditingController password_controller=TextEditingController();
  SignUser(){
    ref.read(AuthControllerProvider).SignUser(AuthModel(email: email_controller.text.trim(), password: password_controller.text.trim(), id: ""),"context");
  }
  // SignUser(){
  //   ref.read(AuthControllerProvider).SignUser(email_controller.text.trim(), password_controller.text.trim());
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade300,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 150,),
              Text("Lets Sign"),
              SizedBox(height: 40,),
              TextFormField(
                controller: email_controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Email"
                ),
              ),
              SizedBox(height: 40,),
              TextFormField(
                controller: password_controller,
                obscureText: eye==false?true:false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Password",
                  suffixIcon: InkWell(
                      onTap: () {
                        eye=!eye;
                        setState(() {
                          
                        });
                      },
                      
                      child:eye==true?Icon(Icons.visibility):Icon(Icons.visibility_off))
                ),
              ),
              SizedBox(height: 40,),
              ElevatedButton(onPressed:() {
                SignUser();
                Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));


              },
                  child:Center(child: Text("SignUp"))),
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
              }, child:Center(child: Text("Login")) )
            ],
          ),
        ),
      ),
    );
  }
}
