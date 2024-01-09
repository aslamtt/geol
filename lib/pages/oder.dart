import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geol/order/controller/order_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../core/providers/firebase_providers.dart';
import '../core/providers/utils.dart';
// import '../core/utils/utils.dart';
import '../main.dart';
import '../order/screens/order_Page.dart';

class oder extends ConsumerStatefulWidget {
   oder({Key? key}) : super(key: key);

  @override
  ConsumerState<oder> createState() => _oderState();
}

class _oderState extends ConsumerState<oder> {
  var isDeviceConnected = false;
  final RoundedLoadingButtonController _btnController= RoundedLoadingButtonController();
  getConnection() async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    ref.watch(isDeviceConnectedProvider.notifier).update((state) => isDeviceConnected );
    if(isDeviceConnected == true){
      _btnController.success();
    }else{
      _btnController.stop();
      showSnackBar(context, "No internet Connection");
    }
    // var subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
    //   _btnController.stop();
    //   if(result != ConnectivityResult.none){
    //     print("if");
    //     isDeviceConnected = await InternetConnectionChecker().hasConnection;
    //     ref.watch(isDeviceConnectedProvider.notifier).update((state) => isDeviceConnected);
    //   }else{
    //     _btnController.reset();
    //     ref.watch(isDeviceConnectedProvider.notifier).update((state) => false);
    //   }
    //
    // });


  }
  List orderList = [
    {
      "text": "New Orders",
      "icon": "assets/new_icons/new_orders.svg",
      "orderStatus": 1,
      "color": const Color(0xffEBE8FF),
      "font": const Color(0xff776CBC),
      "height": h * 0.05,
      "space": h * 0.0,
      "route":Orderview(
        orderStatus: 1,
        productName:"New Orders",

      )
    },
    {
      "text": "Preparing",
      "icon": "assets/new_icons/preparing.svg",
      "orderStatus": 0,
      "color": const Color(0xffFEEBE2),
      "font": const Color(0xffCB957B),
      "height": h * 0.08,
      "space": h * 0.02,
      "route":Orderview(orderStatus: 0, productName: '',)

    },
    {
      "text": "Delivered",
      "icon": "assets/new_icons/delivered.svg",
      "orderStatus": 2,
      "color": const Color(0xffEEF6FD),
      "font": const Color(0xff729DC1),
      "height": h * 0.05,
      "space": h * 0.0,
      "route":Orderview(
        orderStatus: 2,
        productName:"Delivered",

      )

    },
    {
      "text": "Cancelled",
      "icon": "assets/new_icons/cancel.svg",
      "orderStatus": 0,
      "color": const Color(0xffFFEAEA),
      "font": const Color(0xffE50F0F),
      "height": h * 0.065,
      "space": h * 0.02,
      "route":Orderview(orderStatus: 0, productName: '',)

    },
    {
      "text": "Rejected",
      "icon": "assets/new_icons/no_food_FILL0_wght300_GRAD0_opsz48 1.svg",
      "orderStatus": 3,
      "color": const Color(0xffF8F8F8),
      "font": const Color(0xff575757),
      "height": h * 0.05,
      "space": h * 0.0,
      "route":Orderview(
        orderStatus: 3,
        productName:"Rejected",

      )
    },
    ////
    {
      "text": "Pre Orders",
      "icon": "assets/new_icons/pre_orders.svg",
      "orderStatus": 0,
      "color": const Color(0xffFEFFC1),
      "font": const Color(0xff7C7D38),
      "height": h * 0.08,
      "space": h * 0.02,
      "route":Orderview(orderStatus: 0, productName: '',)

    },
    {
      "text": "Order History",
      "icon": "assets/new_icons/order_history.svg",
      "orderStatus": null,
      "color": const Color(0xffFDEEFB),
      "font": const Color(0xffA8569D),
      "height": h * 0.05,
      "space": h * 0.0,
      "route":Orderview(orderStatus: null, productName: '',)

    },
    {
      "text": "Upcoming Orders",
      "icon": "assets/new_icons/upcoming.svg",
      "orderStatus": null,
      "color": const Color(0xffF5FFFD),
      "font": const Color(0xff3F8372),
      "height": h * 0.08,
      "space": h * 0.02,
      "route":Orderview(orderStatus: 0, productName: '',)

    },
  ];
  @override
  void initState() {
    getConnection();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ref.watch(isDeviceConnectedProvider)==false? Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Center(child: Lottie.asset("assets/icons/network.json",height: 250)
              ),
              SizedBox(height: 15,),
              Text("No internet Connection",style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              RoundedLoadingButton(
                  height: h * 0.06,
                  width: w * 0.4,
                  errorColor: Colors.red,
                  successColor: Colors.green,
                  controller: _btnController,
                  onPressed: () => getConnection(),
                  child:Text("Retry",style: TextStyle(fontWeight: FontWeight.bold),))
            ],
          ),
        ),
      ),
    ):
       Scaffold(
        appBar: AppBar(title: Text("ORDER"),centerTitle: true,),
        body:SingleChildScrollView(
          child: Column(
            children: [
              StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    return Consumer(builder: (context, ref, child) {
                      var count = ref.watch(orderList[index]["text"] == "New Orders"?
                      getOrdersCountProvider(1):orderList[index]["text"] == "Delivered"?
                          getOrdersCountProvider(2):
                       orderList[index]["text"] == "Rejected"?
                          getOrdersCountProvider(3):getOrdersCountProvider(0));
                      return InkWell(
                      onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>orderList[index]["route"]));
                      },
                      child: Container(
                      padding: EdgeInsets.only(
                      left: w * 0.02,
                      top: h * 0.006,
                      right: w * 0.02,
                      bottom: h * 0.0),
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(w * 0.05),
                      color: orderList[index]['color']),
                      child: Column(
                      children: [
                      Row(
                      children: [
                        count.when(
                          data: (data) {
                      return CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 14,
                      child: Text(
                      data.toString(),
                      style: GoogleFonts.poppins(
                      color: orderList[index]['font'],
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                      ),
                      );
                      },
                        error: (error, stackTrace) {
                          return CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 14,
                            child: Text(
                              "0",
                              style: GoogleFonts.poppins(
                                  color: orderList[index]['font'],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          );
                        },
                        loading: () {
                          return CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 14,
                            child: Text(
                              "0",
                              style: GoogleFonts.poppins(
                                  color: orderList[index]['font'],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          );
                        },
                        ),

                      ],
                      ),
                      SizedBox(
                      height: orderList[index]['space'],
                      ),
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Center(
                      child: SvgPicture.asset(
                      orderList[index]['icon'],
                      height: orderList[index]['height'],
                      width: w * 0.8,
                      ),
                      ),
                      SizedBox(
                      height: h * 0.01,
                      ),
                      Text(
                      orderList[index]['text'],
                      style: GoogleFonts.poppins(
                      color: orderList[index]['font'],
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                      ),
                      SizedBox(
                      height: h * 0.007,
                      ),
                      ],
                      ),
                      ],
                      ),
                      ),
                      );
                    },

                    );
                    //   Padding(
                    //   padding: const EdgeInsets.all(8),
                    //   child: Container(
                    //     height: 30,
                    //     width: 200,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: orderList[index]["color"],
                    //
                    //     ),
                    //     child: Column(
                    //       children: [
                    //         Row(
                    //           children: [
                    //             Padding(
                    //               padding: const EdgeInsets.all(8.0),
                    //               child: Text(orderList[index]["text"],style: TextStyle(fontSize: 15),),
                    //             ),
                    //             SizedBox(width: 10,),
                    //             Padding(
                    //               padding: const EdgeInsets.only(top: 8.0),
                    //               child: CircleAvatar(
                    //                 radius: 20,
                    //                 child: Text("0"),
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //         Center(
                    //             child: SvgPicture.asset(orderList[index]["icon"]
                    //             ),
                    //
                    //
                    //         )
                    //       ],
                    //     )
                    //     // Stack(
                    //     //   children: [
                    //     //     Positioned(
                    //     //       top: 5,
                    //     //         right:5,
                    //     //         child: CircleAvatar(
                    //     //           radius: 15,
                    //     //       backgroundColor: Colors.grey,
                    //     //           child: Text("0"),
                    //     //     ))
                    //     //   ],
                    //     // ),
                    //   )
                    // );
                  },
                  staggeredTileBuilder:(int index) {
                    double tileHeight = index.isEven ? 0.76 : 1.18;
                    return StaggeredTile.count(1, tileHeight);
                  }, ),


            ],
          ),
        ) ,
      );

  }
}
