import 'package:anuplal/app/services/api_services.dart';
import 'package:flutter/material.dart';

import '../../../controller/home_screen_controller.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_cart_widget.dart';
import 'package:get/get.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<HomeScreenController>(builder: (homeScreenController) {
        return Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(125),
            child: CustomAppBar(
              title: 'Cart',
              isBackButtonExist: true,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: homeScreenController.shopModel[0].products.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    CartItemContainer(
                      imagePath: '${ApiService().imageBaseUrl}${
                        homeScreenController
                            .shopModel[0].products[index].thumbnail
                      }',
                      productName: homeScreenController.shopModel[0].products[index].name,
                      quantity: homeScreenController.shopModel[0].products[index].quantity,
                      price: homeScreenController.shopModel[0].products[index].price,
                    ),
                    SizedBox(height: 10),
                  ],
                );

              },
            ),
          ),
        );
      }),
    );
  }
}