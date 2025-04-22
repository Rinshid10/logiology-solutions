import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:logiology/Data/controller/productscontroller.dart';
import 'package:logiology/View/Home/widgets.dart';
import 'package:logiology/View/productscreen/view.dart';
import 'package:logiology/View/profilepage/profilepage.dart';

class HomePage extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  ),
              child: CircleAvatar(child: Icon(Icons.person)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search products...',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (value) => controller.updateSearch(value),
                      ),
                    ),
                    const Gap(10),
                    GestureDetector(
                      onTap: () => _showFilterDialog(context),
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.filter_list, color: Colors.white),
                            Gap(5),
                            Text(
                              'Filter',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(10),
              Row(
                children: [
                  buildCategoryItem('Clothing', Icons.shopping_bag),
                  buildCategoryItem('Home', Icons.home),
                  buildCategoryItem('Beauty', Icons.spa),
                  buildCategoryItem('Sports', Icons.sports_soccer),
                ],
              ),
              if (controller.selectedCategory.value != null ||
                  controller.tag.value != null ||
                  controller.maxPrice.value < 1000)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (controller.selectedCategory.value != null)
                        FilterChip(
                          label: Text(controller.selectedCategory.value!),
                          onSelected: (_) {
                            controller.selectedCategory.value = null;
                            controller.applyFilters();
                          },
                          deleteIcon: const Icon(Icons.close, size: 16),
                        ),
                      if (controller.tag.value != null)
                        FilterChip(
                          label: Text(controller.tag.value!),
                          onSelected: (_) {
                            controller.tag.value = null;
                            controller.applyFilters();
                          },
                          deleteIcon: const Icon(Icons.close, size: 16),
                        ),
                      if (controller.maxPrice.value < 1000)
                        FilterChip(
                          label: Text(
                            'Max: \$${controller.maxPrice.value.toStringAsFixed(2)}',
                          ),
                          onSelected: (_) {
                            controller.maxPrice.value = 1000;
                            controller.applyFilters();
                          },
                          deleteIcon: const Icon(Icons.close, size: 16),
                        ),
                    ],
                  ),
                ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : controller.filteredProducts.isEmpty
                        ? const Center(child: Text('No products found'))
                        : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(10),
                          itemCount: controller.filteredProducts.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                          itemBuilder: (context, index) {
                            final product = controller.filteredProducts[index];
                            return GestureDetector(
                              onTap:
                                  () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => ProductDetailPage(
                                            id: product.id,
                                            title: product.title,
                                            price: product.price,
                                            rating: product.rating,
                                            image: product.thumbnail,
                                            category: product.category,
                                            description: product.description,
                                          ),
                                    ),
                                  ),
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                              top: Radius.circular(10),
                                            ),
                                        child: Image.network(
                                          product.thumbnail,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              const Spacer(),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 16,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    product.rating.toString(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Container(
                                            height: 35,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                width: 0,
                                                color: Colors.black.withAlpha(
                                                  100,
                                                ),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '\$${product.price.toString()}',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // in here addded  the main logic of the filter of catogery

  void _showFilterDialog(BuildContext context) {
    final categories =
        controller.allProducts
            .map((product) => product.category)
            .toSet()
            .toList();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filter Products'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Category',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('All'),
                      selected: controller.selectedCategory.value == null,
                      onSelected: (_) {
                        controller.selectedCategory.value = null;
                      },
                    ),
                    ...categories.map((category) {
                      return ChoiceChip(
                        label: Text(category),
                        selected: controller.selectedCategory.value == category,
                        onSelected: (_) {
                          controller.selectedCategory.value = category;
                        },
                      );
                    }).toList(),
                  ],
                ),

                const SizedBox(height: 16),
                const Text(
                  'Max Price',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Obx(
                  () => Column(
                    children: [
                      Slider(
                        value: controller.maxPrice.value,
                        min: 0,
                        max: 1000,
                        divisions: 20,
                        label:
                            '\$${controller.maxPrice.value.toStringAsFixed(2)}',
                        onChanged: (value) {
                          controller.maxPrice.value = value;
                        },
                      ),
                      Text('\$${controller.maxPrice.value.toStringAsFixed(2)}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.resetFilters();
                Navigator.pop(context);
              },
              child: const Text('Reset'),
            ),
            TextButton(
              onPressed: () {
                controller.applyFilters();
                Navigator.pop(context);
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }
}
