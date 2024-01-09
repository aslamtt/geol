
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:geol/core/utils/utils.dart';
// import 'package:geol/pages/home.dart';
import 'package:geol/pages/oder.dart';
import 'package:geol/features/product/screens/product.dart';
// import 'package:geol/pages/profile.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'core/providers/firebase_providers.dart';
import 'core/providers/utils.dart';
import 'music.dart';
import 'order/screens/add_order.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key?key}):super(key:key);

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
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
  var subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
    _btnController.stop();
    if(result != ConnectivityResult.none){
      print("if");
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      ref.watch(isDeviceConnectedProvider.notifier).update((state) => isDeviceConnected);
    }else{
      _btnController.reset();
      ref.watch(isDeviceConnectedProvider.notifier).update((state) => false);
    }

  });


}

  String location = "Null, Press Button";
  String Address = "search";
  int Currentindex=0;
  // void getLocation() async{
  //   await Geolocator.checkPermission();
  //   await Geolocator.requestPermission();
  //   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  //   print(position);
  // }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
  Future<void>GetAddressFromLatLong(Position position) async{
    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    Address = "${place.street},${place.subLocality},${place.locality},${place.postalCode},${place.country}";
    setState(() {

    });
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          // bottom: TabBar(tabs: [
          //   Tab(text: "Home",),
          //   Tab(text: "Alert",),
          //   Tab(text: "Profile",),
          // ],
          //
          // ),
          title: Text("Location"),
          actions: [
            IconButton(onPressed: () {
              showModalBottomSheet(context: context,
                builder: (context) {
                  return Aud();
                },);
            }, icon: Icon(Icons.music_note)),
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Addoreder(),));
            }, icon: Icon(Icons.add))
          ],
        ),
        body: Column(
          children: [

            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Text(
                          "Coordinates Points"
                      ),
                      SizedBox(height: 10,),
                      Text(
                          location
                      ),
                      SizedBox(height: 10,),
                      Text("ADDRESS"),
                      SizedBox(height: 10,),
                      Text('${Address}'),
                      ElevatedButton(
                          onPressed: ()async {
                            Position position = await _determinePosition();
                            print(position.latitude);
                            location = "Last: ${position.latitude}, Long: ${position.longitude}";
                            GetAddressFromLatLong(position);
                            setState(() {

                            });


                          },
                          child: Text("Get Location")),
                      SizedBox(height: 20,),
                      Lottie.asset("assets/icons/location.json")
                      // ElevatedButton(
                      //     onPressed: getLocation,
                      //           location = "Last: ${position.latitude}, Long: ${position.longitude}";
                      //           GetAddressFromLatLong(position);
                      //           setState(() {
                      //
                      //           });
                      //     child: Text("Get Location"))
                    ],
                  ),
                ),
              ),
            ),

          ],

        ),


        // This trailing comma makes auto-formatting nicer for build methods.
      ));
  }
}
