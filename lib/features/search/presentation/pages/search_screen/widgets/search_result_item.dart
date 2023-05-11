import 'package:firebase_chat/features/search/data/models/search_result_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../fast_tools/widgets/user_avatar.dart';
import '../../../../../theming/constants/styles.dart';

class SearchResultItem extends StatelessWidget {
  final SearchResultModel model;
  const SearchResultItem({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UserAvatar(
        userImage: model.imageLink,
      ),
      title: Text(
        model.title,
        style: h3LiteTextStyle.copyWith(
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        model.subTitle,
        style: h4TextStyleInactive,
      ),
    );
  }
}
