import 'package:flutter/material.dart';
import 'package:moviemix/presentation/app_localization.dart';

extension StringExtension on String {
  String intelliTrim() {
    return this.length > 15 ? '${this.substring(0, 15)}...' : this;
  }

  String t(BuildContext context) {
    return AppLocalizations.of(context).translate(this);
  }
}
