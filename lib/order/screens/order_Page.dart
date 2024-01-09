import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geol/Models/order_Model.dart';
import 'package:geol/order/controller/order_controller.dart';

import '../../main.dart';
import 'oderSingle.dart';
class Orderview extends ConsumerStatefulWidget {
  final int? orderStatus;
  final String productName;
   Orderview({Key? key,required this.orderStatus,required this.productName}) : super(key: key);
  @override
  ConsumerState<Orderview> createState() => _OrderviewState();
}
class _OrderviewState extends ConsumerState<Orderview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Consumer(builder: (context, ref, child) {
            var data = ref.watch(NewOrderProvider(widget.orderStatus)
                // widget.orderStatus==1?NewOrderProvider(1):widget.orderStatus==2?
                // NewOrderProvider(2):NewOrderProvider(3)
            );
            return data.when(data:(view){
              return  ListView.builder(
                itemCount: view.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  OrderModel user=view[index];
                  return  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>OrderSingle( odrerSing:user),));
                      },
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue.shade300,
                        ),
                        child: ListTile(
                          trailing: Container(
                            height: 30,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.brown.shade200,
                            ),
                            child: Center(child: Text("View",style: TextStyle(fontWeight: FontWeight.bold),)),
                          ),
                          leading: Icon(Icons.fastfood_sharp,color: Colors.pink,),
                          title: Text(user.productName.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Text(user.quandity.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                        )
                      ),
                    ),
                  );
                },
              );
            },
                error: (error , StackTrace){
             return Text(error.toString());
                },
                loading: (){

              return CircularProgressIndicator();
                });
          },
          )
          // Center(child: Text(widget.count.productName.toString()))
        ],
      ),
    );
  }
}
