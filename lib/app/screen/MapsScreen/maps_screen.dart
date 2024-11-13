// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_places_flutter/google_places_flutter.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
//
//
// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController? _controller;
//   LatLng? _currentPosition;
//   String _address = "Search location";
//
//   @override
//   void initState() {
//     super.initState();
//     _setInitialLocation();
//   }
//
//   Future<void> _setInitialLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled, you may want to handle this
//       return;
//     }
//
//     // Check for location permission
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission != LocationPermission.whileInUse &&
//           permission != LocationPermission.always) {
//         return;
//       }
//     }
//
//     // Get current location
//     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       _currentPosition = LatLng(position.latitude, position.longitude);
//     });
//
//     // Move the camera to the current location
//     if (_controller != null) {
//       _controller!.animateCamera(
//         CameraUpdate.newLatLng(_currentPosition!),
//       );
//     }
//   }
//
//   void _onMapCreated(GoogleMapController controller) {
//     _controller = controller;
//     if (_currentPosition != null) {
//       _controller!.animateCamera(
//         CameraUpdate.newLatLng(_currentPosition!),
//       );
//     }
//   }
//
//   Future<void> _getAddressFromLatLng(LatLng position) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );
//       Placemark place = placemarks[0];
//       setState(() {
//         _address = "${place.street}, ${place.locality}, ${place.country}";
//       });
//
//
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Select Location"),
//       ),
//       body: Stack(
//         children: [
//           if (_currentPosition != null)
//             GoogleMap(
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: CameraPosition(
//                 target: _currentPosition!,
//                 zoom: 15,
//               ),
//               onCameraMove: (position) {
//                 setState(() => _currentPosition = position.target);
//               },
//               onCameraIdle: () => _getAddressFromLatLng(_currentPosition!),
//               markers: {
//                 Marker(
//                   markerId: const MarkerId("current"),
//                   position: _currentPosition!,
//                   draggable: true,
//                   onDragEnd: (newPosition) {
//                     _getAddressFromLatLng(newPosition);
//                     setState(() => _currentPosition = newPosition);
//                   },
//                 ),
//               },
//             ),
//           // Positioned(
//           //   top: 20,
//           //   left: 10,
//           //   right: 10,
//           //   child: GooglePlaceAutoCompleteTextField(
//           //     textEditingController: TextEditingController(),
//           //     googleAPIKey: "AIzaSyDkZVirWJryp0GyWKClqPlLJ1oy8ftxMJM",
//           //     inputDecoration: InputDecoration(
//           //       hintText: "Search location",
//           //       fillColor: Colors.white,
//           //       filled: true,
//           //       border: OutlineInputBorder(
//           //         borderRadius: BorderRadius.circular(10),
//           //       ),
//           //     ),
//           //     debounceTime: 600,
//           //     itemClick: (prediction) {
//           //       double lat = double.parse(prediction.lat ?? "0.0");
//           //       double lng = double.parse(prediction.lng ?? "0.0");
//           //       setState(() {
//           //         _currentPosition = LatLng(lat, lng);
//           //       });
//           //       _controller?.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
//           //     },
//           //     getPlaceDetailWithLatLng: (prediction) async {
//           //       double lat = double.parse(prediction.lat ?? "0.0");
//           //       double lng = double.parse(prediction.lng ?? "0.0" );
//           //       setState(() {
//           //         _currentPosition = LatLng(lat, lng);
//           //       });
//           //       _controller?.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
//           //     },
//           //   ),
//           // ),
//           Positioned(
//             bottom: 20,
//             left: 10,
//             child: Container(
//               width: MediaQuery.of(context).size.width - 20,
//               height: 110,
//               padding: const EdgeInsets.all(8),
//               color: Colors.white,
//               child: Column(
//                 children: [
//                   Text(
//                     "Address: $_address",
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   ElevatedButton(child: const Text("Confirm",), onPressed: (){
//                     Navigator.pop(context);
//                   })
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
