import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geol/Models/order_Model.dart';
import 'package:geol/order/controller/order_controller.dart';
import 'package:geol/order/repository/order_repository.dart';

import '../../main.dart';

class Addoreder extends ConsumerStatefulWidget {
  const Addoreder({Key? key}) : super(key: key);

  @override
  ConsumerState<Addoreder> createState() => _AddorederState();
}

class _AddorederState extends ConsumerState<Addoreder> {
  TextEditingController pro_name=TextEditingController();
  TextEditingController pro_price=TextEditingController();
  TextEditingController pro_quandity=TextEditingController();
  TextEditingController pro_status=TextEditingController();
  AddProd(){
    ref.read(OredrControllerProvider).AddProd(OrderModel(
      productName: pro_name.text, price: int.parse(pro_price.text),orderStatus:int.parse(pro_status.text),
      quandity: int.parse(pro_quandity.text),id:"GZO"+Id.toString()
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextFormField(
                controller: pro_name,
                decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: pro_price,
                decoration: InputDecoration(
                  hintText: "Price",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: pro_quandity,
                decoration: InputDecoration(
                  hintText: "Quandity",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: pro_status,
                decoration: InputDecoration(
                  hintText: "Status",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: () {
                  AddProd();
                  pro_quandity.clear();
                  pro_status.clear();
                  pro_price.clear();
                  pro_name.clear();
                },
                child: Container(
                  height: 30,
                  width: 100,
                  color: Colors.blue,
                  child: Center(child: Text("Add")),
                ),
              ),
              SizedBox(height:h*0.3,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {

                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      color: Colors.blue,
                      child: Center(child: Text("New Order",style: TextStyle(fontWeight: FontWeight.bold),)),
                    ),
                  ),

                  InkWell(
                    onTap:  () {
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      color: Colors.red,
                      child: Center(child: Text("Rejected",style: TextStyle(fontWeight: FontWeight.bold),)),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      color: Colors.yellow,
                      child: Center(child: Text("Deliverd",style: TextStyle(fontWeight: FontWeight.bold),)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
