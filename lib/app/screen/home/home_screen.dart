import 'package:anuplal/app/screen/home/components/home_category_component.dart';
import 'package:anuplal/app/screen/home/components/our_services_component.dart';
import 'package:anuplal/app/screen/home/components/recommended_product.dart';
import 'package:anuplal/controller/home_screen_controller.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/images.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utils/sizeboxes.dart';
import '../../models/product_model.dart';
import '../../services/api_services.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  List<PopularProduct> products = [];

  final HomeScreenController homeScreenController = Get.put(HomeScreenController());
  final TextEditingController filter = TextEditingController();
  @override
  void initState() {
    super.initState();
    homeScreenController.fetchProducts(homeScreenController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(builder: (homeScreenController) {
      if(homeScreenController.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                expandedHeight: 170.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .cardColor,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .disabledColor
                              .withOpacity(0.07),
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(Dimensions.radius30)
                          )
                      ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeDefault),
                        child: Column(
                          children: [
                            sizedBox40(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(Images.logo, width: 140,),
                                      Text(
                                        "NAMASKAR",
                                        style: poppinsMedium.copyWith(
                                            color: Theme
                                                .of(context)
                                                .secondaryHeaderColor,
                                            fontSize: Dimensions
                                                .fontSizeDefault),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_sharp,
                                            size: Dimensions.fontSize24,
                                            color: Theme
                                                .of(context)
                                                .primaryColor,),
                                          Flexible(
                                            child: Text(
                                              'NEW DELHI',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: poppinsRegular.copyWith(
                                                fontSize: Dimensions.fontSize14,
                                                color: Theme
                                                    .of(context)
                                                    .disabledColor
                                                    .withOpacity(0.60),
                                                decoration: TextDecoration
                                                    .underline, // Add underline
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Image.asset(Images.icCart,
                                      height: Dimensions.fontSize24,),
                                    sizedBoxW15(),
                                    Image.asset(Images.icNotification,
                                      height: Dimensions.fontSize24,),

                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(40.0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: Dimensions.paddingSizeDefault,
                          right: Dimensions.paddingSizeDefault,
                          bottom: Dimensions.paddingSize20),
                      child: Column(children: [
                        InkWell(onTap: () {},
                          child: Container(
                            height: 45,
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSize5),
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.5,
                                  color: Theme
                                      .of(context)
                                      .disabledColor
                                      .withOpacity(0.10)),
                              color: Theme
                                  .of(context)
                                  .cardColor,
                              borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Theme
                                      .of(context)
                                      .hintColor,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Search",
                                        style: poppinsSemiBold.copyWith(
                                            fontSize: Dimensions.fontSize13,
                                            color: Theme
                                                .of(context)
                                                .hintColor), // Different color for "resend"
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child:
                Column(
                  children: [
                    sizedBoxDefault(),
                    OurServicesComponent(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault),
                      child: Image.asset(Images.imgHomeShopNowBanner),
                    ),
                    sizedBoxDefault(),
                    HomeCategoryComponent(categoryProducts: homeScreenController.categories,homeScreenController: homeScreenController,),
                    sizedBox30(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault),
                      child: Image.asset(Images.imgHomeConsultNowBanner),
                    ),
                    sizedBoxDefault(),
                    RecommendedProduct(products: homeScreenController.products,),
                    sizedBoxDefault(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault),
                      child: Image.asset(Images.imgHomeContactNowBanner),
                    ),


                    sizedBox100(),
                  ],
                ),
              )
            ],

          ));
    });
  }
}


