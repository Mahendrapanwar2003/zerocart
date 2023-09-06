import 'package:get/get.dart';

import '../modules/add_address/bindings/add_address_binding.dart';
import '../modules/add_address/views/add_address_view.dart';
import '../modules/address/bindings/address_binding.dart';
import '../modules/address/views/address_view.dart';
import '../modules/all_reviews/bindings/all_reviews_binding.dart';
import '../modules/all_reviews/views/all_reviews_view.dart';
import '../modules/buy_now/bindings/buy_now_binding.dart';
import '../modules/buy_now/views/buy_now_view.dart';
import '../modules/cancel_order/bindings/cancel_order_binding.dart';
import '../modules/cancel_order/views/cancel_order_view.dart';
import '../modules/category/bindings/category_binding.dart';
import '../modules/category/views/category_view.dart';
import '../modules/category_product/bindings/category_product_binding.dart';
import '../modules/category_product/views/category_product_view.dart';
import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/confirm_cancel/bindings/confirm_cancel_binding.dart';
import '../modules/confirm_cancel/views/confirm_cancel_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/filter/bindings/filter_binding.dart';
import '../modules/filter/views/filter_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main_splash/bindings/main_splash_binding.dart';
import '../modules/main_splash/views/main_splash_view.dart';
import '../modules/measurements/bindings/measurements_binding.dart';
import '../modules/measurements/views/measurements_view.dart';
import '../modules/my_cart/bindings/my_cart_binding.dart';
import '../modules/my_cart/views/my_cart_view.dart';
import '../modules/my_order_details/bindings/my_order_details_binding.dart';
import '../modules/my_order_details/views/my_order_details_view.dart';
import '../modules/my_orders/bindings/my_orders_binding.dart';
import '../modules/my_orders/views/my_orders_view.dart';
import '../modules/navigator_bottom_bar/bindings/navigator_bottom_bar_binding.dart';
import '../modules/navigator_bottom_bar/views/navigator_bottom_bar_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/outfit_room/bindings/outfit_room_binding.dart';
import '../modules/outfit_room/views/outfit_room_view.dart';
import '../modules/privacy_security/bindings/privacy_security_binding.dart';
import '../modules/privacy_security/views/privacy_security_view.dart';
import '../modules/product_detail/bindings/product_detail_binding.dart';
import '../modules/product_detail/views/product_detail_view.dart';
import '../modules/profile_menu/bindings/profile_menu_binding.dart';
import '../modules/profile_menu/views/profile_menu_view.dart';
import '../modules/registration/bindings/registration_binding.dart';
import '../modules/registration/views/registration_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/search_item/bindings/search_item_binding.dart';
import '../modules/search_item/views/search_item_view.dart';
import '../modules/show_banner_images/bindings/show_banner_images_binding.dart';
import '../modules/show_banner_images/views/show_banner_images_view.dart';
import '../modules/slider/bindings/slider_binding.dart';
import '../modules/slider/views/slider_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/tailor/bindings/tailor_binding.dart';
import '../modules/tailor/views/tailor_view.dart';
import '../modules/user_profile/bindings/user_profile_binding.dart';
import '../modules/user_profile/views/user_profile_view.dart';
import '../modules/verification/bindings/verification_binding.dart';
import '../modules/verification/views/verification_view.dart';
import '../modules/zerocart_wallet/bindings/zerocart_wallet_binding.dart';
import '../modules/zerocart_wallet/views/zerocart_wallet_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.MAIN_SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.MAIN_SPLASH,
      page: () => const MainSplashView(),
      binding: MainSplashBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
      /*transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 1000),*/
    ),
    GetPage(
      name: _Paths.SLIDER,
      page: () => const SliderView(),
      binding: SliderBinding(),
      /*transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 1000),*/
    ),
    GetPage(
      name: _Paths.REGISTRATION,
      page: () => const RegistrationView(),
      binding: RegistrationBinding(),
      /*transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 1000),*/
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      /*transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 1000),*/
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
      /*transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 1000),*/
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
      /*transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 1000),*/
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_MENU,
      page: () => const ProfileMenuView(),
      binding: ProfileMenuBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => const CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: _Paths.USER_PROFILE,
      page: () => const UserProfileView(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY_SECURITY,
      page: () => const PrivacySecurityView(),
      binding: PrivacySecurityBinding(),
    ),
    GetPage(
      name: _Paths.ADDRESS,
      page: () => const AddressView(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: _Paths.MEASUREMENTS,
      page: () => const MeasurementsView(),
      binding: MeasurementsBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_ITEM,
      page: () => const SearchItemView(),
      binding: SearchItemBinding(),
    ),
    GetPage(
      name: _Paths.ZEROCART_WALLET,
      page: () => const ZerocartWalletView(),
      binding: ZerocartWalletBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORIE_PRODUCT,
      page: () => const CategoryProductView(),
      binding: CategoryProductBinding(),
    ),
    GetPage(
      name: _Paths.FILTER,
      page: () => const FilterView(),
      binding: FilterBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAIL,
      page: () => const ProductDetailView(),
      binding: ProductDetailBinding(),
      preventDuplicates: false,
    ),
    GetPage(
      name: _Paths.MY_CART,
      page: () => MyCartView(),
      binding: MyCartBinding(),
    ),
    GetPage(
      name: _Paths.MY_ORDERS,
      page: () => const MyOrdersView(),
      binding: MyOrdersBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ADDRESS,
      page: () => const AddAddressView(),
      binding: AddAddressBinding(),
    ),
    GetPage(
      name: _Paths.ALL_REVIEWS,
      page: () => const AllReviewsView(),
      binding: AllReviewsBinding(),
    ),
    GetPage(
      name: _Paths.CANCEL_ORDER,
      page: () => const CancelOrderView(),
      binding: CancelOrderBinding(),
    ),
    GetPage(
      name: _Paths.CONFIRM_CANCEL,
      page: () => const ConfirmCancelView(),
      binding: ConfirmCancelBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_BANNER_IMAGES,
      page: () => const ShowBannerImagesView(),
      binding: ShowBannerImagesBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATOR_BOTTOM_BAR,
      page: () => const NavigatorBottomBarView(),
      binding: NavigatorBottomBarBinding(),
    ),
    GetPage(
      name: _Paths.BUY_NOW,
      page: () => const BuyNowView(),
      binding: BuyNowBinding(),
    ),
    GetPage(
      name: _Paths.VERIFICATION,
      page: () => const VerificationView(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.TAILOR,
      page: () => const TailorView(),
      binding: TailorBinding(),
    ),
    GetPage(
      name: _Paths.OUTFIT_ROOM,
      page: () => const OutfitRoomView(),
      binding: OutfitRoomBinding(),
    ),
    /*GetPage(
      name: _Paths.CHAT_LIST,
      page: () => const ChatListView(),
      binding: ChatListBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.WISHLIST,
      page: () => const WishlistView(),
      binding: WishlistBinding(),
    ),
    GetPage(
      name: _Paths.GROCERY,
      page: () => const GroceryView(),
      binding: GroceryBinding(),
    ),
    GetPage(
      name: _Paths.PHARMACY,
      page: () => const PharmacyView(),
      binding: PharmacyBinding(),
    ),
    GetPage(
      name: _Paths.GROCERY_DETAIL,
      page: () => const GroceryDetailView(),
      binding: GroceryDetailBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMIZATION,
      page: () => const CustomizationView(),
      binding: CustomizationBinding(),
    ),
    GetPage(
      name: _Paths.CATALOGUE,
      page: () => const CatalogueView(),
      binding: CatalogueBinding(),
    ),
    GetPage(
      name: _Paths.DEACTIVATE_ACCOUNT,
      page: () => const DeactivateAccountView(),
      binding: DeactivateAccountBinding(),
    ),
    GetPage(
      name: _Paths.OFFLINE,
      page: () => const OfflineView(),
      binding: OfflineBinding(),
    ),
    GetPage(
      name: _Paths.TEST,
      page: () => const TestView(),
      binding: TestBinding(),
    ),*/
    GetPage(
      name: _Paths.MY_ORDER_DETAILS,
      page: () => const MyOrderDetailsView(),
      binding: MyOrderDetailsBinding(),
    ),
  ];
}
