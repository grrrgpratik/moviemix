import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviemix/common/constants/language.dart';
import 'package:moviemix/presentation/blocs/language/language_cubit.dart';
import 'package:moviemix/presentation/themes/app_color.dart';

import 'navigation_sub_list_item.dart';

class NavigationExpandedListItem extends StatelessWidget {
  final String title;
  final Function onPressed;
  final List<String> children;

  const NavigationExpandedListItem({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            blurRadius: 2,
          ),
        ],
      ),
      child: ExpansionTile(
        collapsedIconColor: AppColor.royalBlue,
        iconColor: AppColor.royalBlue,
        title: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        children: [
          for (int i = 0; i < children.length; i++)
            NavigationSubListItem(
              title: children[i],
              onPressed: () {
                BlocProvider.of<LanguageCubit>(context)
                    .toggleLanguage(Languages.languages[i]);
              },
            ),
        ],
      ),
    );
  }
}
