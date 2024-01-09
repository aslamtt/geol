
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geol/Models/order_Model.dart';
import 'package:geol/order/repository/order_repository.dart';

final OredrControllerProvider = StateProvider((ref)=>OredrController(repository: ref.read(OrderRepositoryProvider)));
final getOrdersCountProvider = StreamProvider.autoDispose.family<int?, int>((ref, orderStatus){
  return ref.watch(OredrControllerProvider).getOrdersCount(orderStatus: orderStatus);
});
final OrderViewProvider = StreamProvider((ref)=>ref.watch(OredrControllerProvider).OrderView());

final NewOrderProvider = StreamProvider.autoDispose
    .family<List<OrderModel>, int?>((ref, orderStatus) {
  return ref
      .watch(OredrControllerProvider)
      .getOrders(orderStatus: orderStatus);
});
// final DelivedOrderProvider = StreamProvider.autoDispose
//     .family<List<OrderModel>, int?>((ref, orderStatus) {
//   return ref
//       .watch(OredrControllerProvider)
//       .getDeliverdOrders(orderStatus: orderStatus);
// });
// final RejectOrderProvider = StreamProvider.autoDispose
//     .family<List<OrderModel>, int?>((ref, orderStatus) {
//   return ref
//       .watch(OredrControllerProvider)
//       .getRejectOrders(orderStatus: orderStatus);
// });

class OredrController {
  final OrderRepository _orderRepository;

  OredrController({required OrderRepository repository })
      : _orderRepository = repository;

  AddProd(OrderModel orderModel) {
    _orderRepository.AddProd(orderModel);
  }

  Stream<int> getOrdersCount({int? orderStatus}){
   return _orderRepository.getOrdersCount(orderStatus: orderStatus);

  }
  Stream<List<OrderModel>>OrderView(){
    return _orderRepository.OrderView();
  }

  Stream<List<OrderModel>> getOrders({int? orderStatus}){
    return _orderRepository.getOrders(orderStatus: orderStatus);
  }
  // Stream<List<OrderModel>> getRejectOrders({int? orderStatus}){
  //   return _orderRepository.getOrders(orderStatus: orderStatus);
  // }
  // Stream<List<OrderModel>> getDeliverdOrders({int? orderStatus}){
  //   return _orderRepository.getOrders(orderStatus: orderStatus);
  // }


}
