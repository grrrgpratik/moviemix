import 'package:flutter/material.dart';
import 'package:moviemix/presentation/themes/app_color.dart';
import 'package:moviemix/common/extension/size_extension.dart';
import 'package:moviemix/common/extension/string_extension.dart';
import 'package:moviemix/common/constants/size_constants.dart';

class Button extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool isEnabled;

  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isEnabled
              ? [AppColor.royalBlue, AppColor.violet]
              : [Colors.grey, Colors.grey],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.dimen_20.w),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
      margin: EdgeInsets.symmetric(vertical: Sizes.dimen_10.h),
      height: Sizes.dimen_20.h,
      child: TextButton(
        onPressed: isEnabled ? onPressed : null,
        child: Text(
          text.t(context),
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}
