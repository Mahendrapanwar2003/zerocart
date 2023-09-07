import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/custom/custom_gradient_text.dart';
import 'package:zerocart/app/modules/home/controllers/home_controller.dart';
import 'package:zerocart/app/routes/app_pages.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';

class MyCustomContainer extends GetView<HomeController> {
  const MyCustomContainer({super.key});

  Widget myCustomContainer({
    bool isSearchActive = false,
    bool isSearch = true,
    bool isClicked = true,
    TextEditingController? textEditingController,
    ValueChanged<String>? onFieldSubmitted,
    Widget? categoriesDropdown,
    ValueChanged<String>? onChanged,
  }) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          color: Theme.of(Get.context!).brightness == Brightness.dark
              ? MyColorsDark().bottomBarColor.withOpacity(0.5.px)
              : MyColorsLight().bottomBarColor.withOpacity(0.5.px),
          child: Column(
            children: [
              SizedBox(height: controller.height.value + 8.px),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 7.px,
                      ),
                      child: Row(
                        children: [
                          appLogo(),
                          SizedBox(width: 8.px),
                          Flexible(child: userWelcomeText()),
                        ],
                      ),
                    ),
                  ),
                  // const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 16.px,
                    ),
                    child: Row(
                      children: [
                        notification(),
                        SizedBox(width: 8.px),
                        wallet(),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.px),
              //const Expanded(child: SizedBox.shrink()),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.px,
                ),
                child: isSearchActive
                    ? searchTextField(
                        onFieldSubmitted: onFieldSubmitted,
                        dropdownWidget: categoriesDropdown,
                        controller: textEditingController,
                        onChanged: onChanged,
                      )
                    : searchTextFieldButton(isSearch: isSearch),
              ),
              SizedBox(height: 18.px),
              /*const Expanded(
                child: SizedBox.shrink(),
              ),*/
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 32.px,
                ),
                child: appBarDash(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*  Widget myCustomContainer(
      {bool isSearchActive = false,
      bool isClicked = true,
      bool isChatOption = false,
      String? text,
      bool isAppBar = false,
      bool? wantProfileMenuDash = false,
      bool isSearch = true,
      VoidCallback? backIconOnPressed,
      VoidCallback? buttonOnPressed,
      IconData? buttonIcon,
      String? buttonText,
      required BuildContext context}) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          color:
              Theme.of(Get.context!).colorScheme.onBackground.withOpacity(0.5),
          height: isAppBar ? 27.8.h : 21.5.h,
          child: Column(
            children: [
              SizedBox(height: 6.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 1.w),
                    child: Row(
                      children: [
                        appLogo(),
                        SizedBox(width: 3.w),
                        userWelcomeText(),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 4.w),
                    child: Row(
                      children: [
                        shoppingCart(
                            context: context,
                            isClicked: isClicked,
                            isSearch: isSearch),
                        SizedBox(width: 2.w),
                        wallet(),
                      ],
                    ),
                  ),
                ],
              ),
              const Expanded(child: SizedBox.shrink()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: isSearchActive
                    ? searchTextField(context: context)
                    : searchTextFieldButton(
                        context: context, isSearch: isSearch),
              ),
              const Expanded(
                child: SizedBox.shrink(),
              ),
              appBarDash(),
              if (isAppBar)
                myStackAppBarSizeBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            backIconView(onPressed: backIconOnPressed ?? () {}),
                            if (text != null && text.isNotEmpty)
                              yourTextView(text: text),
                          ],
                        ),
                        if (buttonText != null && buttonText.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(right: 6.5.w),
                            child: filterButtonView(
                                onPressed: buttonOnPressed ?? () {},
                                icon: buttonIcon,
                                text: buttonText,
                                isChatOption: isChatOption),
                          )
                      ],
                    ),
                    wantProfileMenuDash: wantProfileMenuDash),
            ],
          ),
        ),
      ),
    );
  }*/

  /*Widget myAppBarView({
    bool isIcon = false,
    bool isChatOption = false,
    String? text,
    bool? wantProfileMenuDash = false,
    VoidCallback? backIconOnPressed,
    VoidCallback? buttonOnPressed,
    IconData? buttonIcon,
    String? buttonText,}){
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          color: Theme.of(Get.context!).colorScheme.onBackground.withOpacity(0.5),
          height: 10.h,
          child: Column(
            children: [
              SizedBox(height: 6.h,),
              myStackAppBarSizeBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            isIcon ? backIconView(onPressed: backIconOnPressed ?? (){}): Padding(padding: EdgeInsets.symmetric(horizontal: 4.w)),
                            if (text != null && text.isNotEmpty)
                              yourTextView(text: text),
                          ],
                        ),
                        if(buttonText !=null && buttonText.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(right: 6.5.w),
                            child: filterButtonView(
                                onPressed: buttonOnPressed ?? () {},
                                icon: buttonIcon,
                                text: buttonText, isChatOption: isChatOption),
                          )
                      ],
                    ),
                    wantProfileMenuDash: wantProfileMenuDash
                ),
            ],
          ),
        ),
      ),
    );
  }*/

  AppBar myAppBar(
      {bool isIcon = false,
      bool isChatOption = false,
      String? text,
      VoidCallback? backIconOnPressed,
      VoidCallback? buttonOnPressed,
      IconData? buttonIcon,
      String? buttonText}) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 1,
      shadowColor:
          Theme.of(Get.context!).scaffoldBackgroundColor.withOpacity(.4),
      centerTitle: false,
      leadingWidth: isIcon ? null/*24.px*/ : 0.px,
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      leading: isIcon
          ? backIconView(onPressed: backIconOnPressed ?? () {})
          : null,
      title: (text != null && text.isNotEmpty)
          ? yourTextView(text: text)
          : null,
      actions: [
        buttonText != null && buttonText.isNotEmpty
            ? filterButtonView(
                onPressed: buttonOnPressed ?? () {},
                icon: buttonIcon,
                text: buttonText,
                isChatOption: isChatOption)
            : const SizedBox(),
      ],
    );
  }

  Widget myStackAppBarSizeBox(
      {required Widget child, bool? wantProfileMenuDash = false}) {
    return Column(
      children: [
        wantProfileMenuDash == true
            ? Column(
                children: [
                  child,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    child: CommonWidgets.profileMenuDash(),
                  ),
                ],
              )
            : child,
      ],
    );
  }

  Widget yourTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.subtitle1,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget appBarDash() {
    return Container(
      //width: 70.w,
      height: 2.px,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.px),
          gradient: CommonWidgets.commonLinearGradientView()),
    );
  }

  Widget notification() {
    return InkWell(
      onTap: () => controller.clickOnNotification(),
      radius: 15.px,
      splashColor: MyColorsDark().text,
      child: Obx(
        () {
          print(controller.count.value);
          return Stack(
            children: [
              Container(
                width: 30.px,
                height: 30.px,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: CommonWidgets.commonLinearGradientView()),
                child: Container(
                  margin: EdgeInsets.all(1.2.px),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.px),
                    color: MyColorsLight().secondary,
                  ),
                  child: Center(
                    child: GradientIconColor(
                      Icons.notifications_outlined,
                      gradient: CommonWidgets.commonLinearGradientView(),
                    ),
                    /*child: Image.asset(
                    "assets/notification_white.png",
                    width: 18.px,
                    height: 18.px,
                  ),*/
                  ),
                ),
              ),
              if (controller.notificationCount.value != "0")
                Positioned(
                  right: 1.px,
                  bottom: 20.px,
                  child: Container(
                    height: 10.px,
                    width: 10.px,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: CommonWidgets.commonLinearGradientView(),
                    ),
                    child: Center(
                      child: Text(
                        controller.notificationCount.value,
                        style: Theme.of(Get.context!)
                            .textTheme
                            .headline6
                            ?.copyWith(
                                fontSize: 7.px,
                                color: MyColorsLight().secondary),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

/*  Widget shoppingCart(
      {required BuildContext context,
      required bool isClicked,
      required bool isSearch}) {
    return InkWell(
      onTap: () {
        (isClicked && isSearch) ? clickOnShoppingCart(context: context) : {};
      },
      radius: 15.px,
      splashColor: Colors.white,
      child: Container(
        width: 30.px,
        height: 30.px,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: CommonWidgets.commonLinearGradientView()),
        child: Obx(
          () => Stack(
            children: [
              Container(
                margin: EdgeInsets.all(1.px),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColorsLight().secondary,
                ),
                child: Center(
                  child: Image.asset(
                    "assets/shopping_cart.png",
                    width: 14.px,
                    height: 10.px,
                  ),
                ),
              ),
              if (controller.notificationCount.value != "0")
                Positioned(
                  right: 1.px,
                  bottom: 20.px,
                  child: Container(
                    height: 10.px,
                    width: 10.px,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: CommonWidgets.commonLinearGradientView(),
                    ),
                    child: Center(
                      child: Text(
                        controller.notificationCount.value,
                        style: Theme.of(Get.context!)
                            .textTheme
                            .headline6
                            ?.copyWith(
                                fontSize: 7.px,
                                color: MyColorsLight().secondary),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }*/

  clickOnShoppingCart({required BuildContext context}) {
    Get.toNamed(Routes.MY_CART);
  }

  Widget wallet() {
    return InkWell(
      onTap: () => controller.clickOnWalletCard(),
      borderRadius: BorderRadius.circular(15.px),
      child: Container(
        height: 30.px,
        //width: 30.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.px),
          gradient: CommonWidgets.commonLinearGradientView(),
        ),
        /*constraints: controller.walletAmount.value.length < 5
            ? const BoxConstraints()
            : BoxConstraints(maxWidth: 30.w),*/
        child: Container(
          margin: EdgeInsets.all(1.2.px),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.px),
            color: MyColorsLight().secondary,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.px),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                gradientsText(
                  gradient: CommonWidgets.commonLinearGradientView(),
                  text: Obx(() {
                    print(controller.count.value);
                    return SizedBox(
                      /*
                      width: controller.walletAmount.value.length < 5
                          ? 10.w
                          : 20.w,*/
                      width: controller.walletAmount.value.length < 7
                          ? 10.w
                          : 18.w,
                      child: Text(
                        controller.walletAmount.value,
                        maxLines: 1,
                        style: Theme.of(Get.context!)
                            .textTheme
                            .headline6
                            ?.copyWith(fontSize: 12.px),
                      ),
                    );
                  }),
                ),
                SizedBox(width: 8.px),
                Image.asset(
                  "assets/wallet.png",
                  width: 14.px,
                  height: 14.px,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget gradientsText({
    required Widget text,
    required Gradient gradient,
  }) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: text,
    );
  }

  Widget userWelcomeText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          print(controller.count.value);
          return Text(
            controller.name.value,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(Get.context!).textTheme.subtitle1,
          );
        }),
        Text(
          "Welcome Back!",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: Theme.of(Get.context!).textTheme.headline3,
        ),
      ],
    );
  }

  Widget appLogo() {
    return Image.asset(
      "assets/logo_icon.png",
      width: 48.px,
      height: 48.px,
    );
  }

  Widget searchTextFieldButton({required bool isSearch}) {
    return Theme.of(Get.context!).brightness == Brightness.light
        ? Container(
            height: 36.px,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.px),
              gradient: CommonWidgets.commonLinearGradientView(),
            ),
            child: Container(
              margin: EdgeInsets.all(1.px),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.px),
              ),
              child: ElevatedButton(
                onPressed: () =>
                    controller.clickOnSearchField(isSearch: isSearch),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.px),
                  ),
                  maximumSize: Size(100.w, 50.px),
                  foregroundColor: MyColorsLight().textGrayColor,
                  backgroundColor: MyColorsLight().secondary,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.all(3.5.px),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Icon(Icons.search,
                                color: Theme.of(Get.context!)
                                    .colorScheme
                                    .onSecondary),
                          ),
                          Expanded(
                            flex: 7,
                            child: Text(
                              "Search",
                              style: Theme.of(Get.context!)
                                  .textTheme
                                  .caption
                                  ?.copyWith(fontSize: 10.px),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: VerticalDivider(
                          thickness: 1,
                          color: MyColorsLight().textGrayColor,
                          indent: 6.px,
                          endIndent: 6.px),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              "Category",
                              style: Theme.of(Get.context!)
                                  .textTheme
                                  .caption
                                  ?.copyWith(fontSize: 10.px),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: MyColorsLight().textGrayColor,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : SizedBox(
            height: 36.px,
            child: ElevatedButton(
              onPressed: () =>
                  controller.clickOnSearchField(isSearch: isSearch),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.px),
                ),
                maximumSize: Size(100.w, 50.px),
                foregroundColor: MyColorsLight().textGrayColor,
                backgroundColor: MyColorsLight().secondary,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.all(3.5.px),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Icon(Icons.search,
                              color: Theme.of(Get.context!)
                                  .colorScheme
                                  .onSecondary),
                        ),
                        Expanded(
                          flex: 7,
                          child: Text(
                            "Search",
                            style: Theme.of(Get.context!)
                                .textTheme
                                .caption
                                ?.copyWith(fontSize: 10.px),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: VerticalDivider(
                        thickness: 1,
                        color: MyColorsLight().textGrayColor,
                        indent: 6.px,
                        endIndent: 6.px),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            "Category",
                            style: Theme.of(Get.context!)
                                .textTheme
                                .caption
                                ?.copyWith(fontSize: 10.px),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: MyColorsLight().textGrayColor,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget searchTextField({
    Widget? dropdownWidget,
    TextEditingController? controller,
    ValueChanged<String>? onFieldSubmitted,
    ValueChanged<String>? onChanged,
  }) {
    return Container(
      height: 36.px,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.px),
        gradient: Theme.of(Get.context!).brightness == Brightness.light
            ? CommonWidgets.commonLinearGradientView()
            : LinearGradient(colors: [
                MyColorsLight().secondary,
                MyColorsLight().secondary,
              ]),
      ),
      child: Container(
        height: 36.px,
        margin: EdgeInsets.all(1.px),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.px),
          color: MyColorsLight().secondary,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 9,
              child: TextFormField(
                textInputAction: TextInputAction.search,
                controller: controller,
                onFieldSubmitted: onFieldSubmitted,
                autofocus: true,
                cursorColor: Theme.of(Get.context!).primaryColor,
                style: Theme.of(Get.context!)
                    .textTheme
                    .subtitle2
                    ?.copyWith(color: MyColorsLight().onText),
                maxLines: 1,
                onChanged: onChanged,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                      left: 0, bottom: 0, top: 0, right: 0),
                  hintText: "Search",
                  hintStyle: Theme.of(Get.context!)
                      .textTheme
                      .caption
                      ?.copyWith(fontSize: 10.px),
                  prefixIcon: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20.px),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => clickBackIcon(context: Get.context!),
                      splashRadius: 20.px,
                      icon: Icon(
                        Icons.arrow_back,
                        color: MyColorsLight().textGrayColor,
                        size: 18.px,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: VerticalDivider(
                  thickness: 1,
                  color: MyColorsLight().textGrayColor,
                  indent: 9.px,
                  endIndent: 9.px),
            ),
            Expanded(flex: 4, child: dropdownWidget ?? const Dropdown()),
          ],
        ),
      ),
    );
  }

  clickBackIcon({required BuildContext context}) {
    HomeController homeController = Get.find();
    homeController.onClose();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

/*  Widget filterButtonView({
    required VoidCallback onPressed,
    IconData? icon,
    String? text,
  }) {
    return CommonWidgets.myElevatedButton(
        height: 24.px,
        width: 20.w,
        borderRadius: 2.px,
        text: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (text != null && text.isNotEmpty)
              Text(text,
                  style: Theme.of(Get.context!)
                      .textTheme
                      .button
                      ?.copyWith(fontSize: 12.px, fontWeight: FontWeight.w300)),
            if (icon != null)
              Icon(
                icon,
                size: 18.px,
                color: Theme.of(Get.context!).textTheme.button?.color,
              )
          ],
        ),
        onPressed: onPressed);
  }*/

  Widget filterButtonView(
          {required VoidCallback onPressed,
          IconData? icon,
          String? text,
          required bool isChatOption}) =>
      Padding(
        padding: EdgeInsets.only(right: 4.w),
        child: Center(
          child: Container(
              height: 26.px,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    4.px,
                  ),
                  gradient: CommonWidgets.commonLinearGradientView()),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.px))),
                onPressed: onPressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (icon != null)
                      if (!isChatOption)
                        Icon(
                          Icons.filter_alt_sharp,
                          size: 18.px,
                          color: MyColorsLight().secondary,
                        ),
                    if (text != null && text.isNotEmpty)
                      Text(
                          style: Theme.of(Get.context!)
                              .textTheme
                              .subtitle2
                              ?.copyWith(color: MyColorsLight().secondary),
                          text),
                  ],
                ),
              )),
        ),
      );

  Widget backIconView({required VoidCallback onPressed}) => IconButton(
        onPressed: onPressed,
        icon: Icon(Icons.arrow_back_ios_new_outlined,
            size: 18.px,
            color: Theme.of(Get.context!).textTheme.subtitle1?.color),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      );
}

class Dropdown extends StatefulWidget {
  const Dropdown({super.key});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  List<String> options = <String>['Category', 'Two', 'Three', 'Four'];
  String dropdownValue = 'Category';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(10.px),
      elevation: 5,
      underline: Container(
        color: Colors.transparent,
      ),
      icon: Icon(Icons.keyboard_arrow_down_rounded,
          color: MyColorsLight().textGrayColor, size: 18.px),
      value: dropdownValue,
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return options.map((String value) {
          return SizedBox(
            width: 15.w,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                dropdownValue,
                style: Theme.of(Get.context!)
                    .textTheme
                    .caption
                    ?.copyWith(fontSize: 10.px),
              ),
            ),
          );
        }).toList();
      },
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(Get.context!)
                .textTheme
                .caption
                ?.copyWith(fontSize: 10.px),
          ),
        );
      }).toList(),
    );
  }
}
