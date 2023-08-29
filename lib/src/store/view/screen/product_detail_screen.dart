import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:murok_prj/core/app_color.dart';
import 'package:murok_prj/src/store/model/product.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:murok_prj/src/store/view/widget/page_wrapper.dart';
import 'package:murok_prj/src/store/view/widget/carousel_slider.dart';
import 'package:murok_prj/src/store/controller/product_controller.dart';
import 'package:intl/intl.dart';  // intl 패키지를 임포트
import 'package:murok_prj/core/app_theme.dart';



final ProductController controller = Get.put(ProductController());

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen(this.product, {Key? key}) : super(key: key);

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: Colors.black),
      ),
    );
  }

  Widget productPageView(double width, double height) {
    return Container(
      height: height * 0.42,
      width: width,
      decoration: const BoxDecoration(
        color: Color(0xFFE5E6E8),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(200),
          bottomLeft: Radius.circular(200),
        ),
      ),
      child: CarouselSlider(items: product.images),
    );
  }

  // Widget _ratingBar(BuildContext context) {
  //   return Wrap(
  //     spacing: 30,
  //     crossAxisAlignment: WrapCrossAlignment.center,
  //     children: [
  //       RatingBar.builder(
  //         // initialRating: product.rating,
  //         direction: Axis.horizontal,
  //         itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.amber),
  //         onRatingUpdate: (_) {},
  //       ),
  //       Text(
  //         "(4500 Reviews)",
  //         style: Theme.of(context)
  //             .textTheme
  //             .displaySmall
  //             ?.copyWith(fontWeight: FontWeight.w300),
  //       )
  //     ],
  //   );
  // }

  // Widget productSizesListView() {
  //   return ListView.builder(
  //     scrollDirection: Axis.horizontal,
  //     itemCount: controller.sizeType(product).length,
  //     itemBuilder: (_, index) {
  //       return InkWell(
  //         onTap: () => controller.switchBetweenProductSizes(product, index),
  //         child: AnimatedContainer(
  //           margin: const EdgeInsets.only(right: 5, left: 5),
  //           alignment: Alignment.center,
  //           width: controller.isNominal(product) ? 40 : 70,
  //           decoration: BoxDecoration(
  //             color: controller.sizeType(product)[index].isSelected == false
  //                 ? Colors.white
  //                 : AppColor.lightOrange,
  //             borderRadius: BorderRadius.circular(10),
  //             border: Border.all(color: Colors.grey, width: 0.4),
  //           ),
  //           duration: const Duration(milliseconds: 300),
  //           child: FittedBox(
  //             child: Text(
  //               controller.sizeType(product)[index].numerical,
  //               style: const TextStyle(
  //                 fontWeight: FontWeight.w500,
  //                 fontSize: 15,
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {


    // NumberFormat을 사용하여 price 형식화
    final priceFormatter = NumberFormat('#,##0');
    final formattedPrice = priceFormatter.format(product.price);



    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Theme(
        data: AppTheme.lightAppTheme, // 테마를 설정합니다.
        child:SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _appBar(context),
        body: SingleChildScrollView(
          child: PageWrapper(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                productPageView(width, height),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 10),
                      // _ratingBar(context),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            formattedPrice != null
                                ? "${formattedPrice}원"
                                : "${formattedPrice}원",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          const SizedBox(width: 3),
                          Visibility(
                            visible: product.off != null ? true : false,
                            child: Text(
                              "${formattedPrice}원",
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            product.isAvailable
                                ? "재고 있음"
                                : "재고 없음",
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      // Text(
                      //   "About",
                      //   style: Theme.of(context).textTheme.headlineMedium,
                      // ),
                      const SizedBox(height: 10),
                      Text(product.about),
                      const SizedBox(height: 20),
                      // SizedBox(
                      //   height: 40,
                      //   child: GetBuilder<ProductController>(
                      //     builder: (_) => productSizesListView(),
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: product.isAvailable
                              ? () => controller.addToCart(product)
                              : null,
                          child: const Text("장바구니 담기"),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
