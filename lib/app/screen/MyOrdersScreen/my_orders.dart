import 'package:anuplal/controller/orders_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/sizeboxes.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_buttons.dart';
import 'package:get/get.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  // Initialize the controller once using Get.put.
  final OrdersController ordersController = Get.put(OrdersController());

  @override
  void initState() {
    super.initState();
    ordersController.getOrdersInfo(ordersController);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersController>(builder: (ordersScreenController) {
      // Show a loading indicator if 'order' is null or empty.
      if (ordersScreenController.order.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(125),
            child: const CustomAppBar(
              title: 'Orders',
              isBackButtonExist: true,
        
            ),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: ordersScreenController.order.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0x334C5829)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 62.26,
                          height: 64.10,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            // Uncomment and replace image URL if needed
                            // image: DecorationImage(
                            //   image: NetworkImage("${ApiService().imageBaseUrl}${ordersScreenController.order[index].imageUrl}"),
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Order Code: ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF4C5829),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ordersScreenController.order[index].orderCode,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF4C5829),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Amount: ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF4C5829),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${ordersScreenController.order[index].amount}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF4C5829),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Payment Status: ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF4C5829),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ordersScreenController.order[index].paymentStatus,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF4C5829),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Order Status: ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF4C5829),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ordersScreenController.order[index].orderStatus,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF4C5829),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Placed on: ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF4C5829),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ordersScreenController.order[index].placedAt,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF4C5829),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}