import 'package:anuplal/app/models/category_products.dart';
import 'package:anuplal/app/models/product_details.dart';
import 'package:get/get.dart';

import '../app/models/product_model.dart';
import '../app/services/api_services.dart';

class HomeScreenController extends GetxController implements GetxService {
  bool _isLoading = true;

  bool get isLoading => _isLoading;
  final ApiService apiService = ApiService();

  List<PopularProduct> _products = [];

  List<PopularProduct> get products => _products;
  String _categoryName = "";

  String get categoryName => _categoryName;
  List<CategoryProducts> _categories = [];

  List<CategoryProducts> get categories => _categories;
  List<PopularProduct> _particularCategoriesproducts = [];

  List<PopularProduct> get particularCategoriesproducts =>
      _particularCategoriesproducts;

  Product _productsDetails = Product(
    id: 0,
    name: "",
    description: "",
    price: 0,
    shortDescription: '',
    discountPrice: 0,
    discountPercentage: 0,
    rating: 0,
    totalReviews: 0,
    totalSold: 0,
    quantity: 0,
    isFavorite: false,
    thumbnails: [],
    sizes: [],
    colors: [],
    brand: '',
    shop: ShopOfProduct(
        id: 0,
        name: "",
        logo: "",
        rating: 0,
        estimatedDeliveryTime: "",
        deliveryCharge: 0),
  );

  Product get productsDetails => _productsDetails;

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
    if (fetchedProducts) {
      _isLoading = false;
    }
  }

  Future<bool> fetchParticularCategory(
      HomeScreenController controller, String id) async {
    _categoryName =
        _categories.firstWhere((element) => element.id.toString() == id).name;
    dynamic fetchedProducts =
        await apiService.fetchParticularCategoriesProducts(controller, id);
    if (fetchedProducts) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> fetchParticularDetails(
      HomeScreenController controller, String id) async {
    dynamic fetchedProducts =
        await apiService.fetchProductsDetails(controller, id);
    if (fetchedProducts) {
      return true;
    } else {
      return false;
    }
  }

  void setPopularProductsDetails(Product val) {
    _productsDetails = val;
    update();
  }

  Future<void> addToCart(
      HomeScreenController controller, String id) async {
      await apiService.addToCartApi(controller, id);
    // if (fetchedProducts) {
    //   return true;
    // } else {
    //   return false;
    // }
  }
}
