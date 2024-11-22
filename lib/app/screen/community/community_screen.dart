import 'package:anuplal/app/models/community_model.dart';
import 'package:anuplal/app/screen/community/components/post_component.dart';
import 'package:anuplal/app/widgets/custom_appbar.dart';
import 'package:anuplal/app/widgets/custom_buttons.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/community_controller.dart';
class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {

  CommunityController communityController = Get.put(CommunityController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    communityController.fetchCommunity();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommunityController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(140),
              child: CustomAppBar(title: 'Community',menuWidget: Row(
                children: [
                  CustomNotificationButton(tap: () {  },),
                  sizedBoxW10(),
                  CustomCartButton(tap: () {  },),
                ],
              ),
                isPostButtonExist: true,
              ),
            ),
            body: SingleChildScrollView(
              child: ListView.builder(
                  itemCount: controller.community.data.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (_,i) {
                    return  PostComponent(name: controller.community.data[i].user!.name, title: controller.community.data[i].title, description: controller.community.data[i].description, media_id: controller.community.data[i].mediaId, created_at: controller.community.data[i].createdAt, image: (controller.community.data[i].media?? Media(id: 0, type: "", name: "", src: "", createdAt: "", updatedAt: ""))!.src,);
                  }),
            ),
          ),
        );

      },

    );
  }
}
