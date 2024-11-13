import 'dart:io';

import 'package:anuplal/app/widgets/custom_appbar.dart';
import 'package:anuplal/app/widgets/custom_button_widget.dart';
import 'package:anuplal/app/widgets/custom_buttons.dart';
import 'package:anuplal/app/widgets/custom_network_image.dart';
import 'package:anuplal/app/widgets/underline_textfield.dart';
import 'package:anuplal/controller/profile_controller.dart';
import 'package:anuplal/utils/app_constants.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/images.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../MapsScreen/maps_screen.dart';

class ProfileScreen extends StatefulWidget {
   ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _usernameController = TextEditingController();

   final _emailController = TextEditingController();

   final _phoneController = TextEditingController();

   final _deliveryController = TextEditingController();

  ProfileController profileController = Get.put(ProfileController());

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
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
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
        _deliveryController.text = "${place.street}, ${place.locality}, ${place.country}";
      });

    } catch (e) {
      print(e);
    }
  }


   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setInitialLocation();
    profileController.getProfileInfo(profileController);

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (profileScreenController) {
      if (profileScreenController.profile.phone.isEmpty && _deliveryController.text.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      _usernameController.text = profileScreenController.profile.name;
      _phoneController.text = profileScreenController.profile.phone;

      return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(125),
            child: CustomAppBar(title: 'Account', isBackButtonExist: true,
              menuWidget: Row(
                children: [
                  CustomNotificationButton(tap: () {},),
                  sizedBoxW10(),
                  CustomCartButton(tap: () {},)
                ],
              ),),
          ),
          body: SingleChildScrollView(
              child: GetBuilder<ProfileController>(builder: (profileControl) {
                return Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Column(
                    children: [
                      sizedBox20(),
                      Center(
                        child: Container(
                          height: 150,
                          width: 150,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(shape: BoxShape.circle,
                            border: Border.all(width: 0.5,
                              color: Theme
                                  .of(context)
                                  .primaryColor
                                  .withOpacity(0.40),),
                            color: Theme
                                .of(context)
                                .primaryColor
                                .withOpacity(0.1),
                          ),
                          // alignment: Alignment.center,
                          child: profileControl.pickedImage != null ? Image.file(
                            File(profileControl.pickedImage!.path,), height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                          ) : Stack(
                            children: [
                              Container(
                                  height: 150,
                                  width: 150,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme
                                        .of(context)
                                        .primaryColor
                                        .withOpacity(0.1),
                                  ),
                                  child:
                                  const CustomNetworkImageWidget(
                                    imagePadding: Dimensions.paddingSize40,
                                    height: 150,
                                    width: 150,
                                    image: '',
                                    placeholder: Images.icGallery,
                                    fit: BoxFit.cover,)
                              ),
                              // Image.asset(Images.profilePlaceholder,)
                            ],
                          ),
                        ),
                      ),
                      sizedBoxDefault(),
                      TextFieldWidget(
                        hintText: 'Username', controller: _usernameController,),
                      TextFieldWidget(
                        hintText: 'Email Address', controller: _emailController,),
                      TextFieldWidget(
                        hintText: 'Phone Number', controller: _phoneController,),
                      TextFieldWidget(
                        onPress: () {
                          // Get.to(() => MapScreen());
                        },
                        isReadOnly: true,
                        hintText: 'Delivery location',
                        controller: _deliveryController,
                        suffix: Icon(Icons.location_on_sharp, color: Theme
                            .of(context)
                            .primaryColor,),),
        
                    ],
                  ),
                );
              })
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: SingleChildScrollView(
              child: CustomButtonWidget(buttonText: 'Save',
                onPressed: () {
                  Get.back();
                },),
            ),
          ),
        ),
      );
    });
  }
}
