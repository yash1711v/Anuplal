import 'package:anuplal/app/models/category_products.dart';
import 'package:anuplal/app/widgets/custom_button_widget.dart';
import 'package:anuplal/controller/home_screen_controller.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helper/route_helper.dart';
import '../../../services/api_services.dart';


class HomeCategoryComponent extends StatelessWidget {
  final List<CategoryProducts> categoryProducts;
  final HomeScreenController homeScreenController;
  const HomeCategoryComponent({super.key, required this.categoryProducts, required this.homeScreenController});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Text('Product Categories',style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,
                color: Theme.of(context).primaryColor),),
          ),
          sizedBox10(),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: categoryProducts.length /2,
            ),
            itemCount: categoryProducts.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () async {
                 dynamic val = await homeScreenController.fetchParticularCategory(homeScreenController, categoryProducts[i].id.toString());
                 debugPrint("val $val");
                 if(val){
                   Get.toNamed(RouteHelper.categoryProducts,);
                 } else {}


                },
                child: Container(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () async {
                            dynamic val = await homeScreenController.fetchParticularCategory(homeScreenController, categoryProducts[i].id.toString());
                            if(val){
                              Get.toNamed(RouteHelper.categoryProducts);
                            } else {
                              Get.snackbar('Error', 'Something went wrong');
                            }

                          },
                          child: Image.network("${ApiService().imageBaseUrl}${categoryProducts[i].thumbnail}",height: 70,)),
                      sizedBox4(),
                      Text(textAlign: TextAlign.center,
                          categoryProducts[i].name,
                          style: poppinsMedium.copyWith(fontSize:Dimensions.fontSize14,
                              color: Theme.of(context).hintColor))
                    ],),
                ),
              );
            },),
          // SizedBox(height: 20,),
          // CustomButtonWidget(buttonText: 'View All Services',
          //   onPressed: () {},
          //   isBold: false,
          //   transparent: true,)

        ],
      ),
    );
  }
}
