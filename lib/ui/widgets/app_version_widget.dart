import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_task/cubits/login/login_cubit.dart';

class AppVersionWidget extends StatelessWidget {
  const AppVersionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.bottomCenter,
      child: FutureBuilder<String>(
        future: context.read<LoginCubit>().getBuildVersion(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: Text(
                  'Version ${snapshot.data ?? ''}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
