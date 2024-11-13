import 'package:anuplal/helper/route_helper.dart';
import 'package:get/get.dart';
import 'package:anuplal/app/widgets/custom_appbar.dart';
import 'package:anuplal/app/widgets/custom_buttons.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/material.dart';

import '../MyOrdersScreen/my_orders.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(125),
          child: CustomAppBar(
            title: 'Account',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                sizedBoxDefault(),
                buildColumn(
                  tap: () {
                    Get.toNamed(RouteHelper.getProfileRoute());
                  },
                  title: 'Profile',
                ),
               SizedBox(height: 26),
                buildColumn(tap: () {
                  Get.toNamed(RouteHelper.getmyOrdersRoute());
                  }, title: 'My Orders'),
                SizedBox(height: 26),
                buildColumn(tap: () {
                  Get.toNamed(RouteHelper.getCartRoute());
                }, title: 'Cart'),
                SizedBox(height: 26),
                buildColumn(tap: () {
                  Get.toNamed(RouteHelper.getNotificationRoute());
                }, title: 'Notifications'),
                SizedBox(height: 26),
                buildColumn(tap: () {
                  Get.toNamed(RouteHelper.getCropDoctorRoute());
      
                }, title: 'Crop Doctor'),
                SizedBox(height: 26),
                buildColumn(tap: () {}, title: 'Location'),
                SizedBox(height: 26),
                buildColumn(tap: () {
                  Get.toNamed(RouteHelper.getContactUsRoute());
      
                }, title: 'Contact Us'),
                SizedBox(height: 26),
                buildColumn(tap: () {}, title: 'Privacy Policy'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell buildColumn({
    required Function() tap,
    required String title,
  }) {
    return InkWell(
      onTap: tap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: poppinsRegular.copyWith(
              fontSize: Dimensions.fontSize20,
            ),
          ),
          sizedBox4(),
          Divider(),
        ],
      ),
    );
  }
}
