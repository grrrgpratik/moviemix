import 'package:flutter/material.dart';
import 'package:moviemix/common/constants/size_constants.dart';
import 'package:moviemix/common/extension/size_extension.dart';
import 'package:moviemix/presentation/themes/text_theme.dart';

class LabelFieldWidget extends StatelessWidget {
  final Key? textFieldKey;
  final String label;
  final String hintText;
  final bool isPasswordField;
  final TextEditingController controller;

  const LabelFieldWidget({
    Key? key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.isPasswordField = false,
    this.textFieldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.start,
          ),
          TextField(
            key: textFieldKey,
            obscureText: isPasswordField,
            obscuringCharacter: '*',
            controller: controller,
            style: Theme.of(context).textTheme.headline6,
            decoration: InputDecoration(
              hintText: hintText,
            ),
          ),
        ],
      ),
    );
  }
}
