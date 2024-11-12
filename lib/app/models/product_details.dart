import 'dart:convert';

class Product {
  int id;
  String name;
  String shortDescription;
  double price;
  double discountPrice;
  double discountPercentage;
  double rating;
  int totalReviews;
  int totalSold;
  int quantity;
  bool isFavorite;
  List<Thumbnail> thumbnails;
  List<Size> sizes;
  List<ColorOption> colors;
  String brand;
  String? units;
  ShopOfProduct shop;
  String description;

  Product({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.price,
    required this.discountPrice,
    required this.discountPercentage,
    required this.rating,
    required this.totalReviews,
    required this.totalSold,
    required this.quantity,
    required this.isFavorite,
    required this.thumbnails,
    required this.sizes,
    required this.colors,
    required this.brand,
    this.units,
    required this.shop,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      shortDescription: json['short_description'],
      price: json['price'].toDouble(),
      discountPrice: json['discount_price'].toDouble(),
      discountPercentage: json['discount_percentage'].toDouble(),
      rating: json['rating'].toDouble(),
      totalReviews: int.parse(json['total_reviews']),
      totalSold: int.parse(json['total_sold']),
      quantity: json['quantity'],
      isFavorite: json['is_favorite'],
      thumbnails: List<Thumbnail>.from(json['thumbnails'].map((x) => Thumbnail.fromJson(x))),
      sizes: List<Size>.from(json['sizes'].map((x) => Size.fromJson(x))),
      colors: List<ColorOption>.from(json['colors'].map((x) => ColorOption.fromJson(x))),
      brand: json['brand'],
      units: json['units'],
      shop: ShopOfProduct.fromJson(json['shop']),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'short_description': shortDescription,
      'price': price,
      'discount_price': discountPrice,
      'discount_percentage': discountPercentage,
      'rating': rating,
      'total_reviews': totalReviews.toString(),
      'total_sold': totalSold.toString(),
      'quantity': quantity,
      'is_favorite': isFavorite,
      'thumbnails': List<dynamic>.from(thumbnails.map((x) => x.toJson())),
      'sizes': List<dynamic>.from(sizes.map((x) => x.toJson())),
      'colors': List<dynamic>.from(colors.map((x) => x.toJson())),
      'brand': brand,
      'units': units,
      'shop': shop.toJson(),
      'description': description,
    };
  }
}

class Thumbnail {
  int id;
  String thumbnail;

  Thumbnail({
    required this.id,
    required this.thumbnail,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
      id: json['id'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'thumbnail': thumbnail,
    };
  }
}

class Size {
  int id;
  String name;
  double price;

  Size({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Size.fromJson(Map<String, dynamic> json) {
    return Size(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }
}

class ColorOption {
  int id;
  String name;
  String? colorCode;

  ColorOption({
    required this.id,
    required this.name,
    this.colorCode,
  });

  factory ColorOption.fromJson(Map<String, dynamic> json) {
    return ColorOption(
      id: json['id'],
      name: json['name'],
      colorCode: json['color_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color_code': colorCode,
    };
  }
}

class ShopOfProduct {
  int id;
  String name;
  String logo;
  double rating;
  String estimatedDeliveryTime;
  double deliveryCharge;

  ShopOfProduct({
    required this.id,
    required this.name,
    required this.logo,
    required this.rating,
    required this.estimatedDeliveryTime,
    required this.deliveryCharge,
  });

  factory ShopOfProduct.fromJson(Map<String, dynamic> json) {
    return ShopOfProduct(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      rating: json['rating'].toDouble(),
      estimatedDeliveryTime: json['estimated_delivery_time'],
      deliveryCharge: json['delivery_charge'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'rating': rating,
      'estimated_delivery_time': estimatedDeliveryTime,
      'delivery_charge': deliveryCharge,
    };
  }
}
