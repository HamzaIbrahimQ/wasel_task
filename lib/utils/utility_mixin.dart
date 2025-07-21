import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_task/ui/widgets/app_button.dart';

/// This mixin for all reusable functions
mixin Utility {
  /// To check if device has an internet connection
  Future<bool> checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi)) {
      /// Connected
      return true;
    } else {
      /// Not connected
      return false;
    }
  }

  /// To check if use is logged in or guest
  Future<bool> isLoggedIn() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }


  /// Show guest warning bottom sheet
  void showGuestWarning({required BuildContext context, required Function onConfirm}) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'You need to login to complete your order',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              40.verticalSpace,

              /// Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Logout Button
                  Expanded(
                    child: AppButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onConfirm();
                      },
                      title: 'Login',
                    ),
                  ),

                  8.horizontalSpace,

                  /// Cancel Button
                  Expanded(
                    child: AppButton(
                      onPressed: () => Navigator.pop(context),
                      title: 'Cancel',
                      bgColor: Colors.grey[300],
                      titleColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
