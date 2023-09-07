
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../my_common_method/my_common_method.dart';

class MyFirebaseSignIn {
  static Future<Map<String, dynamic>?> signInWithGoogle(
      {required BuildContext context}) async {
    if (await MyCommonMethods.internetConnectionCheckerMethod()) {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      User? user;
      Map<String, dynamic> userData = {};
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        try {
          final UserCredential userCredential =
              await firebaseAuth.signInWithCredential(authCredential);
          String? token = await FirebaseMessaging.instance.getToken();
          user = userCredential.user;
          userData["uid"] = user?.uid;
          userData["name"] = user?.displayName;
          userData["email"] = user?.email;
          userData["profilePicture"] = user?.photoURL;
          userData["refreshToken"] = user?.refreshToken;
          userData["notificationToken"] = token;
          userData["phone"] = user?.phoneNumber;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            // handle the error here
          } else if (e.code == 'invalid-credential') {
            // handle the error here
          }
        } catch (e) {
          // handle the error here
          MyCommonMethods.showSnackBar(message: "Something want wrong!", context: context);
        }
        return userData;
      } else {
        return null;
      }
    } else {
      MyCommonMethods.networkConnectionShowSnackBar(context: context);
      return null;
    }
  }

 /* add this   flutter_facebook_auth: ^4.4.0+1
  static Future<Map<String, dynamic>?> signInWithFacebook(
      {required BuildContext context}) async {
    if (await MyCommonMethods.internetConnectionCheckerMethod()) {
      Map<String, dynamic>? userDataStore;

      final LoginResult result =
          await FacebookAuth.instance.login(permissions: []);
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        userDataStore = userData;
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
        return userDataStore;
      } else {
        return null;
      }
    } else {
      MyCommonMethods.networkConnectionShowSnackBar(context: context);

      return null;
    }
  }

 */

  static Future<String?> getUserFcmId({required BuildContext context}) async {
    if (await MyCommonMethods.internetConnectionCheckerMethod()) {
      String? token = await FirebaseMessaging.instance.getToken();
      return token;
    } else {
      MyCommonMethods.networkConnectionShowSnackBar(context: context);
      return null;
    }
  }
  static String? signIn(String? email, String? password) {
    if ((email != null && email.isNotEmpty) &&
        (password != null && password.isNotEmpty)) {
      AuthenticationHelper()
          .signIn(email: email, password: password)
          .then((result) {
        if (result == null) {
          return "Login-SuccessFull";
        } else {
          return "Error::}";
        }
      });
    } else {
      return "Please Enter Email or Password";
    }
    return null;
  }

  static String? signUp(String? email, String? password) {
    if (email != null && password != null) {
      AuthenticationHelper()
          .signUp(email: email, password: password)
          .then((result) {
        if (result == null) {
          return "SignUP-SuccessFull";
        } else {
          return "Error::$result";
        }
      });
    } else {
      return "Please Enter Email or Password";
    }
    return null;
  }
}

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();
  }
}

/*add this   firebase_dynamic_links: ^5.0.11
class MyFirebaseDynamicLink {
  static createDynamicLink(
      {required String baseUrl,
      required String uriPrefixFirebase,
      required String packageNameAndroid,
      String? fallbackUrl,
      String? appStoreIdIos,
      String? packageNameIos,
      String? parameter1,
      String? parameter2}) async {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
    //baseUrl like ::::http://dev.gofinx.com your baseurl api
    String link =
        "$baseUrl?parameter1=${parameter1 ?? 'empty'}&parameter2=${parameter2 ?? 'empty'}";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      //uriPrefixFirebase like ::::::::https://gofinx.page.link firebase dynamicLink
      uriPrefix: uriPrefixFirebase,
      link: Uri.parse(link),
      androidParameters: AndroidParameters(
        //fallback like playStore https://play.google.com/store/apps/details?id=com.gofinx.app
        fallbackUrl: Uri.parse(fallbackUrl ?? ''),
        //packageName like com.gofinx.app   ::::::::::your project package Name android
        packageName: packageNameAndroid,
        minimumVersion: 1,
      ),
      iosParameters: IOSParameters(
        //packageName like com.gofinx.app   ::::::::::your project package Name ios
        bundleId: packageNameIos ?? '',
        appStoreId: appStoreIdIos,
        minimumVersion: "1.0.1",
      ),
    );
    return await dynamicLinks.buildShortLink(parameters);
    //await FlutterSocialContentShare.shareOnWhatsapp(shortLink.previewLink.toString(),shortLink.shortUrl.toString());
  }


  static getDynamicInitialLink() async {
    final PendingDynamicLinkData? data =
    await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
        String? parameter1 = deepLink.queryParameters["parameter1"];
        String? parameter2 = deepLink.queryParameters["parameter2"];
        if (parameter1 != null &&
            parameter1.isNotEmpty &&
            parameter2 != null &&
            parameter2.isNotEmpty) {
          if (kDebugMode) {
            print("parameter1::::$parameter1  parameter2$parameter2");
          }
          Map<String,dynamic> map = {"parameter1":parameter1,"parameter2":parameter2};
          return map;
        }else{
          if (kDebugMode) {
            print("parameter1 && parameter2 Are Empty");
            return null;
          }
        }
      }
    }
  }
*/