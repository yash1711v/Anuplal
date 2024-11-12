import 'package:anuplal/app/screen/store/widget/horizontal_product_widget.dart';
import 'package:anuplal/app/widgets/custom_appbar.dart';
import 'package:anuplal/controller/home_screen_controller.dart';
import 'package:anuplal/controller/store_controller.dart';
import 'package:anuplal/helper/route_helper.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/custom_buttons.dart';


class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  StoreController storeController = Get.put(StoreController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storeController.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(builder: (storeController) {
      debugPrint("storeController.categories.isEmpty ${storeController.categories}");
      if (storeController.categories.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: CustomAppBar(title: 'Stores', menuWidget: Row(
              children: [
                CustomNotificationButton(tap: () {},),
                sizedBoxW10(),
                CustomCartButton(tap: () {},)
              ],
            ),),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              sizedBoxDefault(),
              for(int i = 0; i < storeController.categories.length; i++)
                GetBuilder<HomeScreenController>(builder: (homeScreenController) =>
           HorizontalProductWidget(
                    sectionTitle: storeController.categories[i].name,
                    imgList: [
                      'assets/images/img_product_demo.png',
                      'assets/images/img_product_demo.png',
                      'assets/images/img_product_demo.png'
                    ],
                    titleList: ['Seeds', 'Nutrients', 'Seeds',],
                    weightList: ['100 gm', '200 gm', '200 gm'],
                    priceList: ['40', '80', '80'],
                    productTap: () {
                      Get.toNamed(RouteHelper.getProductDetailRoute());
                    },
                    seeAllTap: () async {
                      dynamic val = await homeScreenController.fetchParticularCategory(homeScreenController, storeController.categories[i].id.toString());
                      debugPrint("val $val");
                      if(val){
                        Get.toNamed(RouteHelper.categoryProducts,);
                      } else {}
                    },
                  ),
                ),
              sizedBox100(),
        
        
            ],
            ),
          ),
        ),
      );
    });
  }
}
