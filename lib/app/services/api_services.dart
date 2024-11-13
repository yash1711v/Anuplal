// api_service.dart
import 'dart:async';
import 'dart:convert';
import 'package:anuplal/app/models/category_products.dart';
import 'package:anuplal/controller/home_screen_controller.dart';
import 'package:anuplal/controller/orders_controller.dart';
import 'package:anuplal/controller/profile_controller.dart';
import 'package:anuplal/controller/store_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_model.dart';
import '../models/orders_model.dart';
import '../models/product_details.dart';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../models/profile_model.dart';

class ApiService {
  final String imageBaseUrl = "https://anup.lab5.invoidea.in";
  final String url = 'https://anup.lab5.invoidea.in/api/home';
  final String CategoriesProducturl =
      'https://anup.lab5.invoidea.in/api/category-products?category_id=';
  final String productDetails =
      'https://anup.lab5.invoidea.in/api/product-details?product_id=';
  final String addToCart = "https://anup.lab5.invoidea.in/api/cart/store";
  final String  categoriesListing = "https://anup.lab5.invoidea.in/api/categories";
  final String  profileDetails = "https://anup.lab5.invoidea.in/api/profile";
  final String  myOrders = "https://anup.lab5.invoidea.in/api/orders";
  final String  cartListing = "https://anup.lab5.invoidea.in/api/carts";
  final String decreaseCartItem = "https://anup.lab5.invoidea.in/api/cart/decrement";
  final String increaseCartItem = "https://anup.lab5.invoidea.in/api/cart/increment";
  final String deleteCartItem = "https://anup.lab5.invoidea.in/api/cart/delete";
  final String updateProfile = "https://anup.lab5.invoidea.in/api/update-profile";

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
  Future<bool> fetchNearestCategories(
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


  Future<bool> fetchProfileDetails(
      ProfileController profileScreenController) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token").toString();

    dynamic headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${token}",
    };

    final response = await http.get(Uri.parse(profileDetails),headers: headers);

    if (response.statusCode == 200) {

      final data = json.decode(response.body);
     debugPrint("profileDetails $data");
      User profile = User.fromJson(data['data']['user']);

      profileScreenController.setProfile(profile);

      if (profileScreenController.profile.id != 0) {
        return true;
      } else {
        return false;
      }


      return true;
    } else {
      throw Exception('Failed to load popular products');
    }
  }

  Future<bool> fetchMyOrders(
      OrdersController orderScreenController) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token").toString();

    dynamic headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${token}",
    };

    debugPrint("profileDetails $token");
    final response = await http.get(Uri.parse(myOrders),headers: headers);


    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Order order = Order.fromJson(data['data']['user']);
      final List<dynamic> orderJson = data['data']['orders'];

      debugPrint("orderJson $orderJson");
      List<Order> order = orderJson
          .map((orderJson) => Order.fromJson(orderJson))
          .toList();

      orderScreenController.setOrder(order);

      if (orderScreenController.order.isNotEmpty) {
        return true;
      } else {
        return false;
      }


      return true;
    } else {
      throw Exception('Failed to load popular products');
    }
  }

  Future<dynamic> addToCartApi(
      HomeScreenController homeScreenController, String id)
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token").toString();
    dynamic headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${token}",
    };

    dynamic body = {
      "product_id": id,
    };

    final response = await http.post(Uri.parse(addToCart),body: jsonEncode(body), headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);


      await FetchcartListing(homeScreenController).then((value) {
        return true;
      });
      // return true;
    } else {
      throw Exception('Failed to load popular products');
    }
  }

  Future<bool> FetchcartListing (
      HomeScreenController homeScreenController) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token").toString();

    dynamic headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${token}",
    };

    final response = await http.get(Uri.parse(cartListing),headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);


      final List<dynamic> cartListingJson = data['data']['cart_items'];

      List<ShopModel> shopModel = cartListingJson
          .map((shopModelJson) => ShopModel.fromJson(shopModelJson))
          .toList();

      homeScreenController.addToCartListing(shopModel);

      if (homeScreenController.shopModel.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception('Failed to load popular products');
    }
  }

  Future<dynamic> decreaseCartItemApi(HomeScreenController homeScreenController,String id)
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token").toString();
    dynamic headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${token}",
    };

    dynamic body = {
      "product_id": id,
    };

    final response = await http.post(Uri.parse(decreaseCartItem),body: jsonEncode(body), headers: headers);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
     debugPrint("decreaseCartItemApi $data");
      final List<dynamic> cartListingJson = data['data']['cart_items'];

      List<ShopModel> shopModel = cartListingJson
          .map((shopModelJson) => ShopModel.fromJson(shopModelJson))
          .toList();

      homeScreenController.addToCartListing(shopModel);
      // return true;
    } else {
      throw Exception('Failed to load popular products');
    }
  }

  Future<dynamic> increaseCartItemApi( HomeScreenController homeScreenController, String id,)
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token").toString();
    dynamic headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${token}",
    };

    dynamic body = {
      "product_id": id,
    };

    final response = await http.post(Uri.parse(increaseCartItem),body: jsonEncode(body), headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      debugPrint("increaseData $data");
      final List<dynamic> cartListingJson = data['data']['cart_items'];

      List<ShopModel> shopModel = cartListingJson
          .map((shopModelJson) => ShopModel.fromJson(shopModelJson))
          .toList();

      homeScreenController.addToCartListing(shopModel);
      // return true;
    } else {
      throw Exception('Failed to load popular products');
    }
  }


  Future<dynamic> deleteCartItemApi(HomeScreenController homeScreenController, String id,)
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token").toString();
    dynamic headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${token}",
    };

    dynamic body = {
      "product_id": id,
    };

    final response = await http.post(Uri.parse(deleteCartItem),body: jsonEncode(body), headers: headers);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      debugPrint("deleteCartItem $data");
      final List<dynamic> cartListingJson = data['data']['cart_items'];

      List<ShopModel> shopModel = cartListingJson
          .map((shopModelJson) => ShopModel.fromJson(shopModelJson))
          .toList();

      homeScreenController.addToCartListing(shopModel);
      // return true;
    } else {
      throw Exception('Failed to load popular products');
    }
  }


  Future<dynamic> updateProfileApi(
      ProfileController homeScreenController, User user)
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token").toString();
    dynamic headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${token}",
    };

    dynamic body = {
      "name": user.name,
      "email": user.email,
    };

    final response = await http.post(Uri.parse(updateProfile),body: jsonEncode(body), headers: headers);
    debugPrint("updateProfileApi ${response.body}");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      User profile = User.fromJson(data['data']['user']);

      homeScreenController.setProfile(user);
      if(data['message'] == "Profile updated successfully"){
        return true;
      } else {
        return false;
      }
      // return true;
    } else {
      throw Exception('Failed to load popular products');
    }
  }


}
