
import 'package:anuplal/controller/home_screen_controller.dart';
import 'package:get/get.dart';

import '../app/models/categories_model.dart';
import '../app/models/category_products.dart';
import '../app/services/api_services.dart';

class StoreController extends GetxController implements GetxService {
  bool _isLoading = true;

  bool get isLoading => _isLoading;
  final ApiService apiService = ApiService();

  List<CategoryProducts> _categories = [];

  List<CategoryProducts> get categories => _categories;

  void setCategories(List<CategoryProducts> val) {
    _categories = val;
    update();
  }

  List<NearestShop>  _nearestShop = [];
  List<NearestShop> get nearestShop => _nearestShop;

  void setNearestShop(List<NearestShop> val) {
    _nearestShop = val;
    update();
  }

  Future<bool> fetchCategories() async {
    final bool result = await apiService.fetchCategories(this);
    return result;
  }

  Future<bool> fetchNearestCategories({required String lat, required String long}) async {
    final bool result = await apiService.fetchNearestStore(latitude: lat, longitude: long, homeScreenController: this);
    return result;
  }

}