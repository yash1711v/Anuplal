import 'package:flutter/material.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Cart',
        isBackButtonExist: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            CartItemContainer(
              imagePath: 'assets/images/img_product_demo.png',
              productName: 'Product Name',
              quantity: 2,
              price: 80,
            ),
            SizedBox(height: 10),
            CartItemContainer(
              imagePath: 'assets/images/img_product_demo.png',
              productName: 'Product Name',
              quantity: 2,
              price: 80,
            ),
            SizedBox(height: 10),
            CartItemContainer(
              imagePath: 'assets/images/img_product_demo.png',
              productName: 'Product Name',
              quantity: 2,
              price: 80,
            ),
          ],
        ),
      ),
    );
  }
}