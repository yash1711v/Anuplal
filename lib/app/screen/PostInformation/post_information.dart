import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../../utils/sizeboxes.dart';
import '../../models/profile_model.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/custom_network_image.dart';
import '../../widgets/underline_textfield.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dotted_border/dotted_border.dart';

class PostInformation extends StatefulWidget {
  const PostInformation({super.key});

  @override
  State<PostInformation> createState() => _PostInformationState();
}

class _PostInformationState extends State<PostInformation> {


  final _postTitle = TextEditingController();

  final _postDescription = TextEditingController();

  final _deliveryController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setInitialLocation();
  }

  Future<void> _setInitialLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, you may want to handle this
      return;
    }

    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _getAddressFromLatLng(position);
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];
      setState(() {
        _deliveryController.text =
        "${place.street}, ${place.locality}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(125),
          child: CustomAppBar(title: 'Add Post', isBackButtonExist: true,),
        ),
        body: Column(
          children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
            child: DottedBorder(
              dashPattern: [10, 3],
              borderType: BorderType.RRect,
              color: Colors.grey,
              radius: Radius.circular(12),
              padding: EdgeInsets.all(10),
              child: Container(
                    width: double.infinity,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(Images.icGallery2),),
                        shape: BoxShape.rectangle,
                    ),
              ),
            ),
          ),
        ),
            // Center(
            //   child: Container(
            //     height: 150,
            //     width: 150,
            //     clipBehavior: Clip.hardEdge,
            //     decoration: BoxDecoration(shape: BoxShape.circle,
            //       border: Border.all(width: 0.5,
            //         color: Theme
            //             .of(context)
            //             .primaryColor
            //             .withOpacity(0.40),),
            //       color: Theme
            //           .of(context)
            //           .primaryColor
            //           .withOpacity(0.1),
            //     ),
            //     // alignment: Alignment.center,
            //     child: profileControl.pickedImage != null ? Image.file(
            //       File(profileControl.pickedImage!.path,), height: 90,
            //       width: 90,
            //       fit: BoxFit.cover,
            //     ) : Stack(
            //       children: [
            //         Container(
            //             height: 150,
            //             width: 150,
            //             clipBehavior: Clip.hardEdge,
            //             decoration: BoxDecoration(
            //               shape: BoxShape.circle,
            //               color: Theme
            //                   .of(context)
            //                   .primaryColor
            //                   .withOpacity(0.1),
            //             ),
            //             child:
            //             const CustomNetworkImageWidget(
            //               imagePadding: Dimensions.paddingSize40,
            //               height: 150,
            //               width: 150,
            //               image: '',
            //               placeholder: Images.icGallery,
            //               fit: BoxFit.cover,)
            //         ),
            //         // Image.asset(Images.profilePlaceholder,)
            //       ],
            //     ),
            //   ),
            // ),
            sizedBoxDefault(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFieldWidget(
                maxLength: 10,
                hintText: 'Post Title', controller: _postTitle,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFieldWidget(
                maxLength: 60,
                hintText: 'Post Description', controller: _postDescription,),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFieldWidget(
                onPress: () {
                  // Get.to(() => MapScreen());
                },
                isReadOnly: true,
                hintText: 'Delivery location',
                controller: _deliveryController,
                suffix: Icon(Icons.location_on_sharp, color: Theme
                    .of(context)
                    .primaryColor,),),
            ),
            SizedBox(height: 200,),

          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: SingleChildScrollView(
            child: CustomButtonWidget(buttonText: 'Post',
              onPressed: () {


                // Get.back();
              },),
          ),
        ),
      ),
    );
  }
}
