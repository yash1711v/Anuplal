import 'package:anuplal/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_screen_controller.dart';

class CustomNotificationButton extends StatelessWidget {
  final Function() tap;
  const CustomNotificationButton({super.key, required this.tap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: tap,
        child: Image.asset(Images.icNotification,height: 24,width: 24,));
  }
}


class CustomCartButton extends StatelessWidget {
  final Function() tap;
  const CustomCartButton({super.key, required this.tap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: tap,
        child: Stack(
          children: [
            Image.asset(Images.icCart,height: 30,width: 30,),
        GetBuilder<HomeScreenController>(builder: (homeScreenController) {
          return Visibility(
            visible: homeScreenController.shopModel.isNotEmpty,
            child: Positioned(
              right: 0,
              left: 15,
              bottom: 5,
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: BoxConstraints(
                  minWidth: 5,
                  minHeight: 5,
                ),
                child: Center(
                  child: Text(
                    homeScreenController.shopModel.length.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
          ],
        ));
  }
}
