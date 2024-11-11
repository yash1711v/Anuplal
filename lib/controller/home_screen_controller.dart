
import 'package:anuplal/app/models/category_products.dart';
import 'package:get/get.dart';

import '../app/models/product_model.dart';
import '../app/services/api_services.dart';
class HomeScreenController extends GetxController implements GetxService {

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  final ApiService apiService = ApiService();

  List<PopularProduct> _products = [];
  List<PopularProduct> get products => _products;
  List<CategoryProducts> _categories = [];
  List<CategoryProducts> get categories => _categories;
  List<PopularProduct> _particularCategoriesproducts = [];
  List<PopularProduct> get particularCategoriesproducts => _particularCategoriesproducts;

  void setPopularProducts(List<PopularProduct> val) {
    _products = val;
    update();
  }
  void setCategories(List<CategoryProducts> val) {
    _categories = val;
    update();
  }
  void Categoriesproducts(List<PopularProduct> val) {
    _particularCategoriesproducts = val;
    update();
  }


  Future<void> fetchProducts(HomeScreenController controller) async {
    dynamic fetchedProducts = await apiService.fetchPopularProducts(controller);
    if(fetchedProducts) {
      _isLoading = false;
    }
  }
  Future<bool> fetchParticularCategory(HomeScreenController controller, String id) async {
    dynamic fetchedProducts = await apiService.fetchParticularCategoriesProducts(controller,id);
    if(fetchedProducts) {
      return true;
    } else {
      return false;
    }
  }


}