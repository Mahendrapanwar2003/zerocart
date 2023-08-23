part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const MAIN_SPLASH = _Paths.MAIN_SPLASH;
  static const SPLASH = _Paths.SPLASH;
  static const LOGIN = _Paths.LOGIN;
  static const SLIDER = _Paths.SLIDER;
  static const PROFILE_MENU = _Paths.PROFILE_MENU;
  static const CATEGORY = _Paths.CATEGORY;
  static const USER_PROFILE = _Paths.USER_PROFILE;
  static const PRIVACY_SECURITY = _Paths.PRIVACY_SECURITY;
  static const ADDRESS = _Paths.ADDRESS;
  static const MEASUREMENTS = _Paths.MEASUREMENTS;
  static const SEARCH_ITEM = _Paths.SEARCH_ITEM;
  static const CATEGORIE_PRODUCT = _Paths.CATEGORIE_PRODUCT;
  static const ZEROCART_WALLET = _Paths.ZEROCART_WALLET;
  static const FILTER = _Paths.FILTER;
  static const PRODUCT_DETAIL = _Paths.PRODUCT_DETAIL;
  static const MY_CART = _Paths.MY_CART;
  static const MY_ORDERS = _Paths.MY_ORDERS;
  static const FORGOT_PASSWORD = _Paths.FORGOT_PASSWORD;
  static const RESET_PASSWORD = _Paths.RESET_PASSWORD;
  static const CHANGE_PASSWORD = _Paths.CHANGE_PASSWORD;
  static const EDIT_PROFILE = _Paths.EDIT_PROFILE;
  static const REGISTRATION = _Paths.REGISTRATION;
  static const ADD_ADDRESS = _Paths.ADD_ADDRESS;
  static const ALL_REVIEWS = _Paths.ALL_REVIEWS;
  static const CANCEL_ORDER = _Paths.CANCEL_ORDER;
  static const CONFIRM_CANCEL = _Paths.CONFIRM_CANCEL;
  static const SHOW_BANNER_IMAGES = _Paths.SHOW_BANNER_IMAGES;
  static const NAVIGATOR_BOTTOM_BAR = _Paths.NAVIGATOR_BOTTOM_BAR;
  static const BUY_NOW = _Paths.BUY_NOW;
  static const VERIFICATION = _Paths.VERIFICATION;
  static const NOTIFICATION = _Paths.NOTIFICATION;
  static const OUTFIT_ROOM = _Paths.OUTFIT_ROOM;
  static const TAILOR = _Paths.TAILOR;

/*  static const OTP = _Paths.OTP;
  static const CHAT = _Paths.CHAT;
  static const CHAT_LIST = _Paths.CHAT_LIST;
  static const WISHLIST = _Paths.WISHLIST;
  static const GROCERY = _Paths.GROCERY;
  static const PHARMACY = _Paths.PHARMACY;
  static const GROCERY_DETAIL = _Paths.GROCERY_DETAIL;
  static const CUSTOMIZATION = _Paths.CUSTOMIZATION;
  static const CATALOGUE = _Paths.CATALOGUE;
  static const OFFLINE = _Paths.OFFLINE;
  static const DEACTIVATE_ACCOUNT = _Paths.DEACTIVATE_ACCOUNT;
  static const TEST = _Paths.TEST;*/
  static const MY_ORDER_DETAILS = _Paths.MY_ORDER_DETAILS;
}

abstract class _Paths {
  _Paths._();

  static const HOME = '/home';
  static const MAIN_SPLASH = '/main-splash';
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const SLIDER = '/slider';
  static const PROFILE_MENU = '/profile-menu';
  static const CATEGORY = '/category-';
  static const USER_PROFILE = '/user-profile';
  static const PRIVACY_SECURITY = '/privacy-security';
  static const ADDRESS = '/address';
  static const MEASUREMENTS = '/measurements';
  static const SEARCH_ITEM = '/search-item';
  static const ZEROCART_WALLET = '/zerocart-wallet';
  static const CATEGORIE_PRODUCT = '/categorie-product';
  static const FILTER = '/filter';
  static const PRODUCT_DETAIL = '/product-detail';
  static const MY_CART = '/my-cart';
  static const MY_ORDERS = '/my-orders';
  static const FORGOT_PASSWORD = '/forgot-password';
  static const RESET_PASSWORD = '/reset-password';
  static const CHANGE_PASSWORD = '/change-password';
  static const EDIT_PROFILE = '/edit-profile';
  static const REGISTRATION = '/registration';
  static const ADD_ADDRESS = '/add-address';
  static const ALL_REVIEWS = '/all-reviews';
  static const CANCEL_ORDER = '/cancel-order';
  static const CONFIRM_CANCEL = '/confirm-cancel';
  static const SHOW_BANNER_IMAGES = '/show-banner-images';
  static const NAVIGATOR_BOTTOM_BAR = '/navigator-bottom-bar';
  static const BUY_NOW = '/buy-now';
  static const VERIFICATION = '/verification';
  static const NOTIFICATION = '/notification';
  static const OUTFIT_ROOM = '/outfit-room';
  static const TAILOR = '/tailor';

  /*
      static const TEST = '/test';
      static const CATALOGUE = '/catalogue';
      static const CUSTOMIZATION = '/customization';
      static const OTP = '/otp';
      static const CHAT = '/chat';
      static const CHAT_LIST = '/chat-list';
      static const WISHLIST = '/wishlist';
      static const GROCERY = '/grocery';
      static const PHARMACY = '/pharmacy';
      static const GROCERY_DETAIL = '/grocery-detail';
      static const DEACTIVATE_ACCOUNT = '/deactivate-account';
      static const OFFLINE = '/offline';
   */
  static const MY_ORDER_DETAILS = '/my-order-details';
}
