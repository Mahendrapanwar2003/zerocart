import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/app/custom/custom_appbar.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import 'package:zerocart/progress_bar.dart';
import '../controllers/address_controller.dart';

class AddressView extends GetView<AddressController> {
  const AddressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.onWillPop(context: context),
      child:Obx(() =>  ModalProgress(
        inAsyncCall: controller.response.value&&CommonMethods.isConnect.value,
        child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: const MyCustomContainer().myAppBar(
                isIcon: true,backIconOnPressed: () => controller.clickOnBackIcon(context: context), text: 'My Addresses'),
            body:
            Obx(
                  () {
                 if(CommonMethods.isConnect.value)
                   {
                     if (controller.getCustomerAddresses.value != null) {
                       if (controller.listOfAddress.isNotEmpty) {
                         return ListView(
                           controller: controller.scrollController,
                           physics: const BouncingScrollPhysics(),
                           children: [
                             Padding(
                               padding: EdgeInsets.only(top: Zconstant.margin16/2),
                               child: listOfAddresses(),
                             ),
                             SizedBox(height: 2.5.h),
                             Obx(() {
                               if(controller.isLoading.value)
                               {
                                 return CommonWidgets.progressBarView();
                               }
                               else if(controller.getCustomerAddresses.value?.addresses?.isEmpty ?? false)
                               {
                                 return CommonWidgets.noDataTextView(text: "No more data!");
                               }
                               else
                               {
                                 return const SizedBox();
                               }
                             }),
                             SizedBox(height: 2.5.h,),
                             Column(
                               children: [
                                 addNewAddressButtonView(context: context),
                               ],
                             ),
                             SizedBox(height: Zconstant.margin),
                           ],
                         );

                       } else {
                         return Center(
                             child: addAddressButtonView(context: context)
                         );
                       }
                     } else {
                       return CommonWidgets.somethingWentWrongTextView();
                     }
                   }
                 else
                   {
                    return  CommonWidgets.noInternetTextView();
                   }
              },
            )
        ),
      ),
      ),
    );
  }

  Widget backIconView({required BuildContext context}) => Material(
        color: Colors.transparent,
        child: IconButton(
          onPressed: () => controller.clickOnBackIcon(context: context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(Get.context!).textTheme.subtitle1?.color,
          ),
          splashRadius: 24.px,
          iconSize: 18.px,
        ),
      );

  Widget myAddressesTextView() => Text(
        "My Addresses",
        style: Theme.of(Get.context!).textTheme.subtitle1,
      );

  Widget listOfAddresses() => ListView.builder(
      itemCount: controller.listOfAddress?.length,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        controller.addresses = controller.listOfAddress![index];
        return Column(
          children: [
            InkWell(
              onTap: () => controller.clickOnParticularAddress(
                  addresses: controller.listOfAddress![index],
                  context: context),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Zconstant.margin,
                  vertical: 12.px,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: addressNameTextView(),
                        ),
                        Expanded(
                          flex: 1,
                          child: addressLocationTextView(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: addressDescriptionTextView(),
                        ),
                        const SizedBox(width: 40),
                        (controller.listOfAddress![index].isDefaultAddress != controller.isDefaultAddress && controller.listOfAddress!.length != 1)
                            ? Row(
                                children: [
                                  InkWell(
                                      onTap: () => controller.clickOnDeleteButton(index: index),
                                      splashColor: MyColorsLight().primary,
                                      borderRadius: BorderRadius.circular(4.px),
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.px, vertical: 5.px),
                                          child: deleteTextView())),
                                  InkWell(
                                      onTap: () => controller
                                          .clickOnSelectButton(index: index),
                                      splashColor: MyColorsLight().primary,
                                      borderRadius: BorderRadius.circular(4.px),
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.px, vertical: 5.px),
                                          child: selectTextView())),
                                ],
                              )
                            : selectedTextView()
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Zconstant.margin,
                ),
                child: CommonWidgets.profileMenuDash()),
          ],
        );
      });

  Widget addressNameTextView() => Text(
        "${controller.addresses?.name}",
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px),
      );

  Widget addressLocationTextView() => Text(
        "${controller.addresses?.addressType}",
        textAlign: TextAlign.right,
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px),
      );

  Widget addressDescriptionTextView() => Text(
        "${controller.addresses?.colony},${controller.addresses?.city},${controller.addresses?.state},${controller.addresses?.pinCode} ",
        style: Theme.of(Get.context!).textTheme.caption?.copyWith(fontSize: 12.px),
      );

  Widget deleteTextView() => Text(
        "Delete",
        textAlign: TextAlign.right,
        style:
            Theme.of(Get.context!).textTheme.caption?.copyWith(fontSize: 12.px),
      );

  Widget selectTextView() => Text(
        "Select",
        textAlign: TextAlign.right,
        style: Theme.of(Get.context!).textTheme.headline3,
      );

  Widget selectedTextView() => Text(
        "Selected",
    style:
    Theme.of(Get.context!).textTheme.caption?.copyWith(fontSize: 12.px),

  );

  Widget addNewAddressButtonView({required BuildContext context}) =>
      CommonWidgets.myOutlinedButton(
          radius: 5.px,
          wantFixedSize: false,
          text: addNewAddressTextView(),
          onPressed: () =>
              controller.clickOnAddNewAddressButton(context: context),
          height: 40.px,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.symmetric(horizontal: Zconstant.margin)
          );

  Widget addNewAddressTextView() => Text(
        "ADD NEW ADDRESS",
        style: Theme.of(Get.context!).textTheme.headline3,
      );

  Widget addAddressButtonView({required BuildContext context}) =>
      CommonWidgets.myOutlinedButton(
          radius: 5.px,
          text: addAddressTextView(),
          onPressed: () =>
              controller.clickOnAddNewAddressButton(context: context),
          height: 40.px,
          width: 60.w);

  Widget addAddressTextView() => Text(
    "ADD ADDRESS",
    style: Theme.of(Get.context!).textTheme.headline3,
  );

  Widget emptyAddressImage()
  {
    return Image.asset("assets/address_empty.png");
  }
}
