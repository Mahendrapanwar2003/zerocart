import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/modules/product_detail/controllers/product_detail_controller.dart';

class ProductDetailWidget extends GetView<ProductDetailController> {
  const ProductDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }


  Widget removeHtmlTagsProductAndSellerDescription({required String string}) {
    return Html(
      data: string.trim(),
      shrinkWrap: false,
    );
  }


  Widget customerReview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            starIcon(),
            SizedBox(width: 5.px),
            starIcon(),
            SizedBox(width: 5.px),
            starIcon(),
            SizedBox(width: 5.px),
            starIcon(),
            SizedBox(width: 5.px),
            starIcon(),
          ],
        ),
        SizedBox(height: 1.4.h),
        Text(
          "Amazing !",
          style: Theme.of(Get.context!)
              .textTheme
              .subtitle1
              ?.copyWith(fontSize: 14.px),
        ),
        Text(
          style: Theme.of(Get.context!)
              .textTheme
              .subtitle1
              ?.copyWith(fontSize: 14.px),
          "An amazing fit, i’m around 6 feet with a long feet. This product is absolutely worth every penny. I strongly recommend",
        ),
        SizedBox(height: 1.4.h),
        customerReviewImagesList(),
        SizedBox(height: 1.4.h),
        Text(
          style: Theme.of(Get.context!)
              .textTheme
              .subtitle1
              ?.copyWith(fontSize: 14.px),
          "David Johnson, 1st Jan 2022",
        ),
      ],
    );
  }

  Widget starIcon() {
    return Image.asset(
      "assets/star.png",
    );
  }

  Widget customerReviewImagesList() {
    return Row(
      children: [
        Image.asset("assets/review_product1.png"),
        SizedBox(width: 1.4.h),
        Image.asset("assets/review_product2.png"),
        SizedBox(width: 1.4.h),
        Image.asset("assets/review_product3.png"),
      ],
    );
  }

  Widget moreProductsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
/*
        productAndSellerDescriptionTextView(text: 'You May Also Like'),
*/
        /*textButton(
            text: "See All", onPressed: () => controller.clickOnSeeAllRattingButton()),*/
      ],
    );
  }

}
