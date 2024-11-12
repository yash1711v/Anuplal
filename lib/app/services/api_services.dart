// api_service.dart
import 'dart:convert';
import 'package:anuplal/app/models/category_products.dart';
import 'package:anuplal/controller/home_screen_controller.dart';
import 'package:anuplal/controller/store_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_details.dart';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ApiService {
  final String imageBaseUrl = "https://anup.lab5.invoidea.in";
  final String url = 'https://anup.lab5.invoidea.in/api/home';
  final String CategoriesProducturl =
      'https://anup.lab5.invoidea.in/api/category-products?category_id=';
  final String productDetails =
      'https://anup.lab5.invoidea.in/api/product-details?product_id=';
  final String addToCart = "https://anup.lab5.invoidea.in/api/cart/store";
  final String  categoriesListing = "https://anup.lab5.invoidea.in/api/categories";

  Future<bool> fetchPopularProducts(
      HomeScreenController homeScreenController) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> productsJson = data['data']['popular_products'];
      final List<dynamic> categoryJson = data['data']['categories'];

      List<PopularProduct> products = productsJson
          .map((productJson) => PopularProduct.fromJson(productJson))
          .toList();
      List<CategoryProducts> categoryProducts = categoryJson
          .map((categoryJson) => CategoryProducts.fromJson(categoryJson))
          .toList();
      homeScreenController.setPopularProducts(products);
      homeScreenController.setCategories(categoryProducts);

      if (homeScreenController.products.isNotEmpty &&
          homeScreenController.categories.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception('Failed to load popular products');
    }
  }

  Future<bool> fetchParticularCategoriesProducts(
      HomeScreenController homeScreenController, String id) async {
    final response = await http.get(Uri.parse('$CategoriesProducturl$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> productsJson = data['data']['products'];
      debugPrint("productsJson $productsJson");
      List<PopularProduct> particularCategoriesProducts = productsJson
          .map((productJson) => PopularProduct.fromJson(productJson))
          .toList();

      homeScreenController.Categoriesproducts(particularCategoriesProducts);

      if (homeScreenController.particularCategoriesproducts.isNotEmpty) {
        return true;
      } else {
        return true;
      }
    } else {
      throw Exception('Failed to load popular products');
    }
  }

  Future<bool> fetchProductsDetails(
      HomeScreenController homeScreenController, String id) async {
    final response = await http.get(Uri.parse('$productDetails$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final dynamic productsDetailsJson = data['data']['product'];

      debugPrint("productsDetails $productsDetailsJson");

      Product productsDetails =
          Product.fromJson(productsDetailsJson as Map<String, dynamic>);

      debugPrint("productsDetails $productsDetails");

      homeScreenController.setPopularProductsDetails(productsDetails);

      return true;
    } else {
      throw Exception('Failed to load popular products');
    }
  }

  Future<void> addToCartApi(
      HomeScreenController homeScreenController, String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token").toString();
    dynamic headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${token}",
    };

    dynamic body = {
      "product_id": id,
    };
debugPrint("addToCart $body");
    final response = await http.post(Uri.parse('$addToCart'),body: jsonEncode(body), headers: headers);
    debugPrint("addToCart ${response.body}");

    // if (response.statusCode == 200) {
    //   final data = json.decode(response.body);
    //   debugPrint("addToCart $data");
    //   // final dynamic productsDetailsJson = data['data']['product'];
    //   //
    //   // debugPrint("productsDetails $productsDetailsJson");
    //   //
    //   // Product productsDetails = Product.fromJson(productsDetailsJson as Map<String, dynamic>);
    //   //
    //   // debugPrint("productsDetails $productsDetails");
    //   //
    //   // homeScreenController.setPopularProductsDetails(productsDetails);
    //
    //   // return true;
    // } else {
    //   throw Exception('Failed to load popular products');
    // }
  }

  Future<bool> fetchCategories(
      StoreController store) async {
    final response = await http.get(Uri.parse(categoriesListing));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> categoryJson = data['data']['categories'];

      List<CategoryProducts> categoryProducts = categoryJson
          .map((categoryJson) => CategoryProducts.fromJson(categoryJson))
          .toList();
      store.setCategories(categoryProducts);

      if (store.categories.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception('Failed to load popular products');
    }
  }

}
