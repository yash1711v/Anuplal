// api_service.dart
import 'dart:convert';
import 'package:anuplal/app/models/category_products.dart';
import 'package:anuplal/controller/home_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ApiService {
  final String imageBaseUrl = "https://anup.lab5.invoidea.in";
  final String url = 'https://anup.lab5.invoidea.in/api/home';

  Future<bool> fetchPopularProducts(HomeScreenController homeScreenController) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> productsJson = data['data']['popular_products'];
      final List<dynamic> categoryJson = data['data']['categories'];
      debugPrint("Products: $productsJson");
      debugPrint("Products: $categoryJson");
      List<PopularProduct> products = productsJson
          .map((productJson) => PopularProduct.fromJson(productJson))
          .toList();
      List<CategoryProducts> categoryProducts = categoryJson
          .map((categoryJson) => CategoryProducts.fromJson(categoryJson))
          .toList();
      homeScreenController.setPopularProducts(products);
      homeScreenController.setCategories(categoryProducts);

      if (homeScreenController.products.isNotEmpty && homeScreenController.categories.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception('Failed to load popular products');
    }
  }
}