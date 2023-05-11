// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:firebase_chat/core/errors/failure.dart';
import 'package:firebase_chat/features/search/presentation/providers/search_provider.dart';
import 'package:firebase_chat/features/theming/theme_calls.dart';
import 'package:firebase_chat/utils/global_utils.dart';
import 'package:firebase_chat/utils/providers_calls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/types.dart';
import '../../../../../../fast_tools/widgets/custom_text_field.dart';
import '../../../../../theming/constants/sizes.dart';
import '../../../../../theming/constants/styles.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      snap: true,
      stretch: true,
      floating: true,
      pinned: false,
      automaticallyImplyLeading: false,
      backgroundColor: colorTheme.backGround,
      flexibleSpace: FlexibleSpaceBar(
        background: Align(
          alignment: Alignment.center,
          child: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      BackButton(
                        color: colorTheme.inActiveText,
                      ),
                      Expanded(
                        child: Selector<SearchProvider, bool>(
                          selector: (p0, p1) => p1.searching,
                          shouldRebuild: (previous, next) => previous != next,
                          builder: (context, value, child) => CustomTextField(
                            title: 'Search...',
                            enabled: !value,
                            controller: searchController,
                            autoFocus: true,
                            textInputType: TextInputType.text,
                            onSubmitted: (v) async {
                              if (v.isEmpty) return;
                              var res =
                                  await Providers.searchPf(context).search(v);
                              var data = res.fold((l) => l, (r) => r);
                              if (data is Failure) {
                                GlobalUtils.showSnackBar(
                                  context: context,
                                  message: ErrorMapper(data).map(),
                                  snackBarType: SnackBarType.error,
                                );
                              }
                            },
                            obscureText: false,
                            color: Colors.red,
                            backgroundColor:
                                colorTheme.textFieldBackgroundColor,
                            borderColor: Colors.transparent,
                            textStyle: h4TextStyleInactive,
                            borderRadius: BorderRadius.circular(
                              mediumBorderRadius,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
