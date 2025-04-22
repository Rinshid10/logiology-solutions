import 'package:get/get.dart';
import 'package:logiology/Data/model/productModel/productmodel.dart';
import 'package:logiology/Data/repositories/products/products.dart';

class ProductController extends GetxController {
  var allProducts = <ProductsModel>[].obs;
  var filteredProducts = <ProductsModel>[].obs;
  var searchQuery = ''.obs;

  var selectedCategory = RxnString();
  var maxPrice = RxDouble(1000);
  var tag = RxnString();

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  // this is the function for fetching the datas from api
  void fetchProducts() async {
    isLoading.value = true;
    try {
      final products = await ApiService.fetchProducts();
      allProducts.assignAll(products);
      filteredProducts.assignAll(products);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  // this is the function to filter the products

  void applyFilters() {
    filteredProducts.value =
        allProducts.where((product) {
          final matchesCategory =
              selectedCategory.value == null ||
              product.category == selectedCategory.value;
          final matchesTag =
              tag.value == null ||
              product.title.toLowerCase().contains(tag.value!.toLowerCase());
          final matchesPrice = product.price <= maxPrice.value;
          final matchesSearch =
              searchQuery.value.isEmpty ||
              product.title.toLowerCase().contains(
                searchQuery.value.toLowerCase(),
              );

          return matchesCategory && matchesTag && matchesPrice && matchesSearch;
        }).toList();
  }

  void resetFilters() {
    selectedCategory.value = null;
    tag.value = null;
    maxPrice.value = 1000;
    applyFilters();
  }

  void updateSearch(String query) {
    searchQuery.value = query;
    applyFilters();
  }
}
