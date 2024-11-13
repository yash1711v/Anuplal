import 'package:anuplal/app/screen/store/widget/horizontal_product_widget.dart';
import 'package:anuplal/app/widgets/custom_appbar.dart';
import 'package:anuplal/controller/home_screen_controller.dart';
import 'package:anuplal/controller/store_controller.dart';
import 'package:anuplal/helper/route_helper.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/custom_buttons.dart';


class NearestStore extends StatefulWidget {
  const NearestStore({super.key});

  @override
  State<NearestStore> createState() => _NearestStoreState();
}

class _NearestStoreState extends State<NearestStore> {
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
            preferredSize: const Size.fromHeight(125),
            child: CustomAppBar(
              isBackButtonExist: true,
              title: 'Nearest Store', menuWidget: Row(
              children: [
                CustomNotificationButton(tap: () {},),
                sizedBoxW10(),
                CustomCartButton(tap: () {},)
              ],
            ),),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      'NEAREST STORE',
                      style: TextStyle(
                        color: Color(0xFF4C5829),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
              sizedBoxDefault(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: 324,
                  height: 116.90,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/324x117"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              sizedBoxDefault(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet accumsan arcu. Pellentesqu',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              sizedBoxDefault(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  width: double.infinity,
                  height: 46,
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(1.00, -0.02),
                      end: Alignment(-1, 0.02),
                      colors: [Color(0xFF739A2B), Color(0xFF4C5829)],
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: (){},
                    child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone, color: Colors.white,),
                        SizedBox(width: 10,),
                        Text(
                          'Contact Store',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        )
                      ],
                    ),),
                ),
              ),
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
