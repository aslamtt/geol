import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geol/features/auth/controller/auth_controller.dart';
import 'package:geol/features/auth/screens/singup.dart';

class Login extends ConsumerStatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  bool eye=false;
  TextEditingController email_controller=TextEditingController();
  TextEditingController password_controller=TextEditingController();
  LoginUser(){
    ref.read(AuthControllerProvider).LoginUser(email_controller.text, password_controller.text, context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 150,),
              Text("Lets Login"),
              SizedBox(height: 40,),
              TextFormField(
                controller: email_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "EmailNmae"
                ),
              ),
              SizedBox(height: 40,),
              TextFormField(
                obscureText: eye==false?true:false,
                controller: password_controller,
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
              ElevatedButton(onPressed: () {
                LoginUser();
              }, child: Center(child: Text("Login"))),
              SizedBox(height: 40,),
              ElevatedButton(onPressed: () {
                LoginUser();
                Navigator.push(context, MaterialPageRoute(builder: (context) => Signup(),));
              }, child: Center(child: Text("Lets SingUp")))

            ],
          ),
        ),
      ),
    );
  }
}
