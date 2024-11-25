// api_service.dart
import 'dart:async';
import 'dart:convert';
import 'package:anuplal/app/models/category_products.dart';
import 'package:anuplal/controller/community_controller.dart';
import 'package:anuplal/controller/home_screen_controller.dart';
import 'package:anuplal/controller/orders_controller.dart';
import 'package:anuplal/controller/profile_controller.dart';
import 'package:anuplal/controller/store_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/route_helper.dart';
import '../models/cart_model.dart';
import '../models/community_model.dart';
import '../models/orders_model.dart';
import '../models/product_details.dart';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mime/mime.dart';

import '../models/profile_model.dart';
import 'package:http_parser/http_parser.dart';

class ApiService {
  final String imageBaseUrl = "https://anup.lab5.invoidea.in";
  final String url = 'https://anup.lab5.invoidea.in/api/home';
  final String CategoriesProducturl =
      'https://anup.lab5.invoidea.in/api/category-products?category_id=';
  final String productDetails =
      'https://anup.lab5.invoidea.in/api/product-details?product_id=';
  final String addToCart = "https://anup.lab5.invoidea.in/api/cart/store";
  final String categoriesListing =
      "https://anup.lab5.invoidea.in/api/categories";
  final String profileDetails = "https://anup.lab5.invoidea.in/api/profile";
  final String myOrders = "https://anup.lab5.invoidea.in/api/orders";
  final String cartListing = "https://anup.lab5.invoidea.in/api/carts";
  final String decreaseCartItem =
      "https://anup.lab5.invoidea.in/api/cart/decrement";
  final String increaseCartItem =
      "https://anup.lab5.invoidea.in/api/cart/increment";
  final String deleteCartItem = "https://anup.lab5.invoidea.in/api/cart/delete";
  final String logout = "https://anup.lab5.invoidea.in/api/logout";
  final String updateProfile =
      "https://anup.lab5.invoidea.in/api/update-profile";
  final String commentApi = "https://anup.lab5.invoidea.in/api/comment-store";
  final String bookApi = "https://anup.lab5.invoidea.in/api/place-order";
  final String getCommentsApi = "https://anup.lab5.invoidea.in/api/comments-details";
  final String comunity = "https://anup.lab5.invoidea.in/api/comunity";
  final String comunityPost =
      "https://anup.lab5.invoidea.in/api/comunity-store";

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

  Future<void> fetchCommunity(CommunityController communityController) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token").toString();

    dynamic headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${token}",
    };

    final response = await http.get(Uri.parse(comunity), headers: headers);
    debugPrint("comunity ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      CommunityResponse communityResponse = CommunityResponse.fromJson(data);
      communityController.setCommunity(communityResponse.data.community);
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

  Future<bool> fetchCategories(StoreController store) async {
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

  Future<bool> fetchNearestCategories(StoreController store) async {
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

    final response =
        await http.get(Uri.parse(profileDetails), headers: headers);

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

  Future<bool> fetchMyOrders(OrdersController orderScreenController) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token").toString();

    dynamic headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${token}",
    };

    debugPrint("profileDetails $token");

    final response = await http.get(Uri.parse(myOrders), headers: headers);
    debugPrint("orderJson $response");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      debugPrint("orderJson $data");
      // Order order = Order.fromJson(data['data']['user']);
      final List<dynamic> orderJson = data['data']['orders'];

      debugPrint("orderJson $orderJson");
      List<Order> order =
          orderJson.map((orderJson) => Order.fromJson(orderJson)).toList();

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

    final response = await http.post(Uri.parse(addToCart),
        body: jsonEncode(body), headers: headers);

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

  Future<bool> FetchcartListing(
      HomeScreenController homeScreenController) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token").toString();

    dynamic headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${token}",
    };

    final response = await http.get(Uri.parse(cartListing), headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final List<dynamic> cartListingJson = data['data']['cart_items'];
debugPrint("cartListingJson $cartListingJson");
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

  Future<dynamic> decreaseCartItemApi(
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

    final response = await http.post(Uri.parse(decreaseCartItem),
        body: jsonEncode(body), headers: headers);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);


      final List<dynamic> cartListingJson = data['data']['cart_items'];

      List<ShopModel> shopModel = cartListingJson
          .map((shopModelJson) => ShopModel.fromJson(shopModelJson))
          .toList();

      // return true;
    } else {
      throw Exception('Failed to load popular products');
    }
  }

  Future<dynamic> increaseCartItemApi(
    HomeScreenController homeScreenController,
    String id,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token").toString();
    dynamic headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${token}",
    };

    dynamic body = {
      "product_id": id,
    };

    final response = await http.post(Uri.parse(increaseCartItem),
        body: jsonEncode(body), headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      debugPrint("increaseData $data");
      final List<dynamic> cartListingJson = data['data']['cart_items'];

      List<ShopModel> shopModel = cartListingJson
          .map((shopModelJson) => ShopModel.fromJson(shopModelJson))
          .toList();

      // return true;
    } else {
      throw Exception('Failed to load popular products');
    }
  }

  Future<dynamic> deleteCartItemApi(
    HomeScreenController homeScreenController,
    String id,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token").toString();
    dynamic headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${token}",
    };

    dynamic body = {
      "product_id": id,
    };

    final response = await http.post(Uri.parse(deleteCartItem),
        body: jsonEncode(body), headers: headers);
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
      ProfileController homeScreenController, User user,
      [int? registerationStatus]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token").toString();
    dynamic headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${token}",
    };

    dynamic body = {
      "name": user.name,
      "email": user.email,
      "register_status": registerationStatus ?? 1,
    };

    final response = await http.post(Uri.parse(updateProfile),
        body: jsonEncode(body), headers: headers);
    debugPrint("updateProfileApi ${response.body}");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      User profile = User.fromJson(data['data']['user']);

      homeScreenController.setProfile(user);
      if (data['message'] == "Profile updated successfully") {
        return true;
      } else {
        return false;
      }
      // return true;
    } else {
      throw Exception('Failed to load popular products');
    }
  }

  Future<dynamic> logOutApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token").toString();

    dynamic headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${token}",
    };

    final response = await http.post(Uri.parse(logout), headers: headers);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      debugPrint("logout $data");
      prefs.setString("token", "");
      Get.toNamed(RouteHelper.login);
      // return true;
    } else {
      throw Exception('Failed to load popular products');
    }
  }

  Future<dynamic>? communityPostApi(
      {required String title,
      required String description,
      required String user_id,
      required dynamic image}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get("token").toString();

    final url = Uri.parse(comunityPost);

    var request = http.MultipartRequest('Post', url);
    request.headers['Authorization'] = "Bearer $token";
    request.headers['Content-Type'] = "application/json";

    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['user_id'] = user_id;

    if (image != null && image.isNotEmpty) {
      var mimeType =
          lookupMimeType(image); // Detect MIME type (e.g., image/jpeg)
      var file = await http.MultipartFile.fromPath(
        'community_image', // Field name expected by the backend
        image, // File path
        contentType: MediaType.parse(mimeType!), // Set MIME type explicitly
      );
      request.files.add(file);
    }

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      debugPrint("Response body: $responseBody");
      return jsonDecode(responseBody);
    } else {
      debugPrint("Upload failed with status: ${response.statusCode}");
      debugPrint("Response body: $responseBody");
    }

    return null;
  }

  Future<dynamic> CommentOnApi(
      {required String user_id, required String comment, required String post_id})
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token").toString();
    dynamic headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${token}",
    };

    dynamic body = {
      "user_id": int.parse(user_id),
      "posts_id": int.parse(post_id),
      "comments": comment,
    };

    debugPrint("CommentOnApi $body");

    final response = await http.post(Uri.parse(commentApi),
        body: jsonEncode(body), headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      debugPrint("CommentOnApi $data");
      if(data['message'].toString().trim() == "Success !!"){
        return true;}else{
        return false;
      }

    } else {
      throw Exception('Failed to load popular products');
    }
  }

  Future<dynamic>? getComments(String postId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token").toString();
    dynamic headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${token}",
    };

    var body = {
      "post_id": postId,
    };

    final response = await http.post(Uri.parse(getCommentsApi), headers: headers,body: jsonEncode(body));

    debugPrint("postId $postId");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      debugPrint("getCommentOnApi $data");
      if(data['message'].toString().trim() == "Comments Details"){
        return data['data']['comments'];}else{
        return [];
      }

    } else {
      throw Exception('Failed to load comments products');
    }
  }


  Future<dynamic> bookOrder(
      {required List<ShopModel> shopModel})
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token").toString();
    dynamic headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${token}",
    };

    dynamic body = {
      "products": shopModel[0].products!.map((product) => product.toJson()).toList(),
      "payment_method": "cash"
    };

    debugPrint("postOnApi ${jsonEncode(body)}");

    final response = await http.post(Uri.parse(bookApi),
        body: jsonEncode(body), headers: headers);

    debugPrint("reponse ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      debugPrint("CommentOnApi $data");
    } else {
      throw Exception('Failed to load popular products');
    }
  }

}
