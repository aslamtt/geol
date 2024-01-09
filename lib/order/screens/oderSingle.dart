import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geol/Models/order_Model.dart';

import '../../main.dart';

class OrderSingle extends ConsumerStatefulWidget {
 OrderModel odrerSing;
   OrderSingle({super.key,required this.odrerSing});

  @override
  ConsumerState createState() => _OrderSingleState();
}

class _OrderSingleState extends ConsumerState<OrderSingle> {
  int count=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 140,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.brown.shade300,
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.odrerSing.productName.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    Divider(thickness: 5,),
                    Text((count*widget.odrerSing.price!).toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    // Text(widget.odrerSing.quandity.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    Padding(
                      padding: const EdgeInsets.only(left: 12,top: 8.0),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                if(count>1){
                                  count--;
                                }else{
                                  count=1;
                                }
                                setState(() {

                                });
                              },
                              child: Container(

                                  width: w*0.08,
                                  height: w*0.08,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.blueGrey.shade400,
                                  ),

                                  child: Icon(Icons.remove,color: Colors.white,))),
                          SizedBox(width: w*0.01,),

                          Container(
                              width: w*0.08,
                              height: w*0.08,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.blueGrey.shade400,
                              ),
                              child: Center(child: Text(count.toString()))),
                          SizedBox(width: w*0.01,),
                          InkWell(
                              onTap: () {
                                  count++;
                                setState(() {
                                });
                              },
                              child: Container(
                                  width: w*0.08,
                                  height: w*0.08,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.blueGrey.shade400,
                                  ),

                                  child: Icon(Icons.add,color: Colors.white,))),
                        ],
                      ),
                    ),

                  ],


                ),
              ),
            ),
          )
        ],
      ),

    );
  }
}
