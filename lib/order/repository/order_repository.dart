
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geol/Models/order_Model.dart';
import 'package:geol/core/constands/firebase_constands.dart';
import 'package:geol/core/providers/firebase_providers.dart';
var Id;
final OrderRepositoryProvider = Provider((ref)=>OrderRepository(firestore: ref.read(firestoreProvider)));

class OrderRepository{
  final FirebaseFirestore _firebaseFirestore;
 OrderRepository({required FirebaseFirestore firestore})
  : _firebaseFirestore = firestore;
 AddProd(OrderModel orderModel) async {
   // _firebaseFirestore.collection(FirebaseConstands.orderCollcetion).
   // // doc("order").set(orderModel.toMap());
   //   add(orderModel.toMap()).then((value) => value.update({"id":value.id}));
   var iddata = await FirebaseFirestore.instance.collection("settings").doc("settings").get();
   Id=iddata.get("vendorid");
   iddata.reference.update({"vendorid":FieldValue.increment(1)});
   // FirebaseFirestore.instance.collection("order").
  _order.doc("GZO"+Id.toString()).set(orderModel.toMap());
 }
  Stream<int> getOrdersCount({int? orderStatus}) {
    DateTime from = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
    DateTime to = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 23, 59, 59);
    if (orderStatus == 1) {
      return _order
          .where("orderStatus", isEqualTo: orderStatus)
          // .where("orderDate", isLessThanOrEqualTo: to)
          // .orderBy("orderDate")
          .snapshots()
          .map((event) {
        // List<OrderModel> orders = [];
        // for (var a in event.docs) {
        //   orders.add(OrderModel.fromJson(a.data() as Map<String, dynamic>));
        // }
        return event.docs.length;
      });
    } else if (orderStatus == 2) {
      return _order
          .where("orderStatus", isEqualTo: 2)
          // .where("mbus", arrayContains: finalUserId)
          // .where("deliveredDate", isGreaterThanOrEqualTo: from)
          // .where("deliveredDate", isLessThanOrEqualTo: to)
      // .orderBy("orderDate")
          .snapshots()
          .map((event) {
        // List<OrderModel> orders = [];
        // for (var a in event.docs) {
        //   orders.add(OrderModel.fromJson(a.data() as Map<String, dynamic>));
        // }
        return event.docs.length;
      });
    } else if(orderStatus==3){
      return _order
          .where("orderStatus", isEqualTo:3)
          // .where("mbus", arrayContains: finalUserId)
          .snapshots()
          .map((event) {
        // List<OrderModel> orders = [];
        // for (var a in event.docs) {
        //   orders.add(OrderModel.fromJson(a.data() as Map<String, dynamic>));
        // }
        return event.docs.length;
      });
    }else {
      return _order
          .where("orderStatus", isEqualTo: orderStatus)
          // .where("mbus", arrayContains: finalUserId)
          .snapshots()
          .map((event) {
        // List<OrderModel> orders = [];
        // for (var a in event.docs) {
        //   orders.add(OrderModel.fromJson(a.data() as Map<String, dynamic>));
        // }
        return event.docs.length;
      });
    }
  }

  Stream<List<OrderModel>> OrderView() {
    return _firebaseFirestore
        .collection(FirebaseConstands.orderCollcetion)
        .snapshots()
        .map((event) =>
        event.docs.map((e) => OrderModel.fromMap(e.data())).toList());
  }
  Stream<List<OrderModel>> getOrders({int? orderStatus}) {
    if(orderStatus==null){
      return _order
          .snapshots()
          .map((event) {
        List<OrderModel> orders = [];
        for (var a in event.docs) {
          orders.add(OrderModel.fromMap(a.data() as Map<String, dynamic>));
        }
        return orders;
      });
    }else{
      return _order
          .where("orderStatus", isEqualTo: orderStatus)
          .snapshots()
          .map((event) {
        List<OrderModel> orders = [];
        for (var a in event.docs) {
          orders.add(OrderModel.fromMap(a.data() as Map<String, dynamic>));
        }
        return orders;
      });
    }

  }

  CollectionReference get _order => _firebaseFirestore.collection(FirebaseConstands.orderCollcetion);
 }