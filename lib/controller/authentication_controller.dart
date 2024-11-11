import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../app/widgets/commontoast.dart';
import '../helper/route_helper.dart';

class LoginController extends GetxController {
  // URL of the API endpoint
  final String _url = 'https://anup.lab5.invoidea.in/api/send-login-otp';
  final String _otpUrl = 'https://anup.lab5.invoidea.in/api/verify-login-otp';
  // Observables for handling loading and response states
  var isLoading = false.obs;
  var loginResponse = {}.obs;

  // Method to handle login
  Future<void> login(String phone,) async {
    isLoading.value = true; // Show loading indicator

    try {
      final response = await http.post(
        Uri.parse(_url),
        // headers: {'Content-Type': 'application/json',  'Authorization': '••••••'},
        body: {'mobile': "7518141111",},
      );

      if (response.statusCode == 200) {
        loginResponse.value = jsonDecode(response.body);
        print('Login successful: ${loginResponse.value}');
        CommonToast('Login successful');
      } else {
        print('Failed to login: ${response.body}');
        CommonToast('Failed to login');
      }
    } catch (error) {
      print('Error: $error');
      CommonToast('$error');
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }

  Future<void> otpVerify(String phone,String otp,) async {
    isLoading.value = true; // Show loading indicator
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await http.post(
        Uri.parse(_otpUrl),
        // headers: {'Content-Type': 'application/json',  'Authorization': '••••••'},
        body: {'mobile': "7518141111", 'otp': otp},);
      if (response.statusCode == 200) {
        loginResponse.value = jsonDecode(response.body);
          prefs.setString('token', loginResponse.value['token']);
           Get.toNamed(RouteHelper.getLocationPickRoute());
      } else {
        print('Failed to otp: ${response.body}');
        CommonToast('Failed to otp');
      }
    } catch (error) {
      print('Error: $error');
      CommonToast('$error');
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }

}