import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/images.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class PostComponent extends StatelessWidget {
 final  String name;
 final  String title;
 final  String description;
 final  int media_id;
 final String created_at;
 final String image;
  const PostComponent({super.key, required this.name, required this.title, required this.description, required this.media_id, required this.created_at, required this.image});

  @override
  Widget build(BuildContext context) {
    debugPrint('image: $image');
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,maxLines: 1,overflow: TextOverflow.ellipsis,
            style: poppinsSemiBold.copyWith(fontSize: Dimensions.fontSize14,
          color: Theme.of(context).primaryColor),),
          Text(created_at,maxLines: 1,overflow: TextOverflow.ellipsis,
            style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize12,
                color: Theme.of(context).hintColor),),
          sizedBoxDefault(),
          Container(
            height: 200,width: Get.size.width,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
            ),child: Image.network('https://anup.lab5.invoidea.in/storage/${image}',fit: BoxFit.cover,),
          ),
          sizedBoxDefault(),
          Text(title,maxLines: 2,overflow: TextOverflow.ellipsis,
            style: poppinsSemiBold.copyWith(fontSize: Dimensions.fontSize14,
                color: Theme.of(context).disabledColor),),
          Text(description,maxLines: 3,overflow: TextOverflow.ellipsis,
            style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,
                color: Theme.of(context).hintColor),),
          Divider(),
          TextButton(
            onPressed: () {  },
            child: Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(Images.icComment,height: 24,width: 24,),
                sizedBoxW5(),
                Text('Comment',style: poppinsMedium.copyWith(fontSize: Dimensions.fontSize14,
                color: Theme.of(context).primaryColor),)
              ],
            ),
          )



        ],
      ),
    );
  }
}
