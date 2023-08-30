import 'package:flutter/material.dart';
import 'package:murok_prj/src/store/model/product.dart';
import 'package:murok_prj/src/store/view/animation/open_container_wrapper.dart';

import 'package:intl/intl.dart';  // intl 패키지를 임포트


class ProductGridView extends StatelessWidget {
  const ProductGridView({
    Key? key,
    required this.items,
    // required this.isPriceOff,
    // required this.likeButtonPressed,
  }) : super(key: key);

  final List<Product> items;
  // final bool Function(Product product) isPriceOff;
  // final void Function(int index) likeButtonPressed;

  Widget _gridItemHeader(Product product, int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        ],
      ),
    );
  }

  Widget _gridItemBody(Product product) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E6E8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.asset(product.images[0], scale: 5),
    );
  }

  Widget _gridItemFooter(Product product, BuildContext context) {


    // NumberFormat을 사용하여 price 형식화
    final priceFormatter = NumberFormat('#,##0');
    final formattedPrice = priceFormatter.format(product.price);


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: Text(
                product.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  formattedPrice != null
                      ? "${formattedPrice}원"
                      : "${formattedPrice}원",
                  style: Theme.of(context).textTheme.headlineMedium,
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GridView.builder(
        itemCount: items.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.7,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (_, index) {
          Product product = items[index];
          return OpenContainerWrapper(
            product: product,
            child: GridTile(
              header: _gridItemHeader(product, index),
              footer: _gridItemFooter(product, context),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  _gridItemBody(product), // _gridItemBody를 여기에 직접 배치
                  // 원하는 추가 컨텐츠를 여기에 추가할 수 있음
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
