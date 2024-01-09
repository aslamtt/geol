import 'package:flutter/material.dart';

import '../../../main.dart';
import 'addProduct.dart';

class productpage extends StatefulWidget {
  const productpage({Key? key}) : super(key: key);

  @override
  State<productpage> createState() => _productpageState();
}

class _productpageState extends State<productpage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_back_ios_new),
                  SizedBox(width: 5,),

                  Container(
                    height: w * 0.145,
                    width: w*0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 7,
                            color: Colors.grey
                          )
                        ],
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 5,),
                        Icon(Icons.backpack_sharp),
                        SizedBox(width: 8,),
                        Text("Add Products"),
                        SizedBox(width: 85,),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddProduct(),));
                          },
                          child: Container(
                            height: w*0.100,
                            width: w*0.13,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.pink,
                            ),
                            child: Icon(Icons.add,color: Colors.white,),

                          ),
                        )
                      ],
                    ),
                   
                  )


                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
