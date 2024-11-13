
import 'package:get/get.dart';

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

  Future<bool> fetchCategories() async {
    final bool result = await apiService.fetchCategories(this);
    return result;
  }
  Future<bool> fetchNearestCategories() async {
    final bool result = await apiService.fetchNearestCategories(this);
    return result;
  }

}