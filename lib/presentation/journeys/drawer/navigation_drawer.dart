import 'package:flutter/material.dart';
import 'package:moviemix/common/constants/language.dart';
import 'package:moviemix/common/constants/size_constants.dart';
import 'package:moviemix/common/constants/translation_constants.dart';
import 'package:moviemix/common/extension/size_extension.dart';
import 'package:moviemix/common/extension/string_extension.dart';
import 'package:moviemix/presentation/widgets/logo.dart';

import 'navigation_expanded_list_item.dart';
import 'navigation_list_item.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            blurRadius: 4,
          ),
        ],
      ),
      width: Sizes.dimen_300.w,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: Sizes.dimen_8.h,
                bottom: Sizes.dimen_18.h,
                left: Sizes.dimen_8.w,
                right: Sizes.dimen_8.w,
              ),
              child: Logo(
                height: Sizes.dimen_20.h,
              ),
            ),
            NavigationListItem(
              title: TranslationConstants.favoriteMovies.t(context),
              onPressed: () {},
            ),
            NavigationExpandedListItem(
              title: TranslationConstants.language.t(context),
              children: Languages.languages.map((e) => e.value).toList(),
              onPressed: () {},
            ),
            NavigationListItem(
              title: TranslationConstants.feedback.t(context),
              onPressed: () {},
            ),
            NavigationListItem(
              title: TranslationConstants.about.t(context),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
