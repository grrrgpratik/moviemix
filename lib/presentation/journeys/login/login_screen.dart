import 'package:flutter/material.dart';
import 'package:moviemix/common/constants/size_constants.dart';
import 'package:moviemix/presentation/widgets/logo.dart';
import 'package:moviemix/common/extension/size_extension.dart';

import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: Sizes.dimen_32.h),
              child: Column(
                children: [
                  Image.asset(
                    'assets/png/logo2.png',
                    // color: Colors.white,
                    // width: Sizes.dimen_12.h,
                  ),
                  Logo(height: Sizes.dimen_12.h),
                ],
              ),
            ),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}
