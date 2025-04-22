class ProductsModel {
  final int id;
  final String title;
  final double price;
  final double rating;
  final String thumbnail;
  final String category;
  final String description;

  ProductsModel({
    required this.id,
    required this.title,
    required this.price,
    required this.rating,
    required this.thumbnail,
    required this.category,
    required this.description,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      thumbnail: json['thumbnail'],
      category: json['category'],
      description: json['description'],
    );
  }
}
