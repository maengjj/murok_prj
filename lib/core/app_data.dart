import 'package:murok_prj/src/store/model/bottom_navy_bar_item.dart';
import 'package:murok_prj/src/store/model/recommended_product.dart';
import 'package:murok_prj/src/store/model/product_size_type.dart';
import 'package:murok_prj/src/store/model/product_category.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:murok_prj/src/store/model/categorical.dart';
import 'package:murok_prj/src/store/model/numerical.dart';
import 'package:murok_prj/src/store/model/product.dart';
import 'package:flutter/material.dart';

class AppData {
  const AppData._();

  static String dummyText ='';

  static List<Product> products = [
    Product(
      name: '가드닝 토양 영양제',
      price: 5100,
      about: dummyText,
      isAvailable: true,
      quantity: 0,
      images: [
        'images/nutrient.png',
      ],
      isFavorite: false,
      rating: 1,
      type: ProductType.mobile,
    ),
    Product(
      name: '소케르 물뿌리개',
      price: 9900,
      about: dummyText,
      isAvailable: true,
      quantity: 0,
      images: [
        'images/watering.png',
      ],
      isFavorite: false,
      rating: 4,
      type: ProductType.tablet,
    ),
    Product(
      name: '모종삽 3종 세트',
      price: 6900,
      about: dummyText,
      isAvailable: true,
      off: null,
      quantity: 0,
      images: [
        'images/shovel.png',
      ],
      isFavorite: false,
      rating: 3,
      type: ProductType.tablet,
    ),
    Product(
      name: '베란다 텃밭 화분',
      price: 11200,
      about: dummyText,
      isAvailable: true,
      quantity: 0,
      images: [
        'images/pot.png',
      ],
      isFavorite: false,
      rating: 5,
      type: ProductType.watch,
    ),
    Product(
      name: '분갈이 흙',
      price: 8000,
      about: dummyText,
      isAvailable: true,
      quantity: 0,
      images: [
        'images/soil.png',
      ],
      isFavorite: false,
      rating: 4,
      type: ProductType.watch,
    ),
    // Product(
    //     name: 'Beats studio 3',
    //     price: 230,
    //     about: dummyText,
    //     isAvailable: true,
    //     off: null,
    //     quantity: 0,
    //     images: [
    //       'assets/images/beats_studio_3-1.png',
    //       'assets/images/beats_studio_3-2.png',
    //       'assets/images/beats_studio_3-3.png',
    //       'assets/images/beats_studio_3-4.png',
    //     ],
    //     isFavorite: false,
    //     rating: 2,
    //     type: ProductType.headphone),
    // Product(
    //   name: 'Samsung Q60 A',
    //   price: 497,
    //   about: dummyText,
    //   isAvailable: true,
    //   off: null,
    //   quantity: 0,
    //   images: [
    //     'assets/images/samsung_q_60_a_1.png',
    //     'assets/images/samsung_q_60_a_2.png',
    //   ],
    //   isFavorite: false,
    //   rating: 3,
    //   sizes: ProductSizeType(
    //     numerical: [
    //       Numerical('43', true),
    //       Numerical('50', false),
    //       Numerical('55', false)
    //     ],
    //   ),
    //   type: ProductType.tv,
    // ),
    // Product(
    //   name: 'Sony x 80 J',
    //   price: 498,
    //   about: dummyText,
    //   isAvailable: true,
    //   off: null,
    //   quantity: 0,
    //   images: [
    //     'assets/images/sony_x_80_j_1.png',
    //     'assets/images/sony_x_80_j_2.png',
    //   ],
    //   isFavorite: false,
    //   sizes: ProductSizeType(
    //     numerical: [
    //       Numerical('50', true),
    //       Numerical('65', false),
    //       Numerical('85', false)
    //     ],
    //   ),
    //   rating: 2,
    //   type: ProductType.tv,
    // ),
  ];

  static List<ProductCategory> categories = [
    ProductCategory(
      ProductType.all,
      true,
      Icons.all_inclusive,
    ),
    ProductCategory(
      ProductType.mobile,
      false,
      FontAwesomeIcons.mobileScreenButton,
    ),
    ProductCategory(ProductType.watch, false, Icons.watch),
    ProductCategory(
      ProductType.tablet,
      false,
      FontAwesomeIcons.tablet,
    ),
    ProductCategory(
      ProductType.headphone,
      false,
      Icons.headphones,
    ),
    ProductCategory(
      ProductType.tv,
      false,
      Icons.tv,
    ),
  ];

  static List<Color> randomColors = [
    const Color(0xFFFCE4EC),
    const Color(0xFFF3E5F5),
    const Color(0xFFEDE7F6),
    const Color(0xFFE3F2FD),
    const Color(0xFFE0F2F1),
    const Color(0xFFF1F8E9),
    const Color(0xFFFFF8E1),
    const Color(0xFFECEFF1),
  ];

  static List<BottomNavyBarItem> bottomNavyBarItems = [
    BottomNavyBarItem(
      "홈",
      const Icon(Icons.home),
      const Color(0xFF087560),
      Colors.grey,
    ),
    // BottomNavyBarItem(
    //   "좋아요",
    //   const Icon(Icons.favorite),
    //   const Color(0xFF087560),
    //   Colors.grey,
    // ),
    BottomNavyBarItem(
      "장바구니",
      const Icon(Icons.shopping_cart),
      const Color(0xFF087560),
      Colors.grey,
    ),
    // BottomNavyBarItem(
    //   "주문정보",
    //   const Icon(Icons.person),
    //   const Color(0xFF087560),
    //   Colors.grey,
    // ),
  ];

  static List<RecommendedProduct> recommendedProducts = [
    RecommendedProduct(
      imagePath: "",
      cardBackgroundColor: const Color(0xFF087560),
    ),
    RecommendedProduct(
      imagePath: "",
      cardBackgroundColor: const Color(0xFF3081E1),
      buttonBackgroundColor: const Color(0xFF9C46FF),
      buttonTextColor: Colors.white,
    ),
  ];
}
