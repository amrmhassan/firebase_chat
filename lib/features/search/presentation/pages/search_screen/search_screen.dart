// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:firebase_chat/fast_tools/widgets/screen_wrapper.dart';
import 'package:firebase_chat/fast_tools/widgets/v_space.dart';
import 'package:firebase_chat/features/search/data/models/search_result_model.dart';
import 'package:firebase_chat/features/search/presentation/pages/search_screen/widgets/search_app_bar.dart';
import 'package:firebase_chat/features/search/presentation/providers/search_provider.dart';
import 'package:firebase_chat/features/theming/constants/styles.dart';
import 'package:firebase_chat/features/theming/theme_calls.dart';
import 'package:firebase_chat/utils/providers_calls.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import 'widgets/search_result_item.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/SearchScreen';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var searchProvider = Providers.searchP(context);

    return ScreenWrapper(
      backgroundColor: colorTheme.backGround,
      body: CustomScrollView(
        slivers: [
          SearchAppBar(searchController: searchController),
          SliverToBoxAdapter(child: VSpace()),
          searchProvider.searching
              ? SliverToBoxAdapter(
                  child: Column(
                    children: [
                      VSpace(),
                      LoadingAnimationWidget.halfTriangleDot(
                        color: colorTheme.cardBackgroundDark.withOpacity(.5),
                        size: 100,
                      ),
                      VSpace(factor: .5),
                      Text(
                        'Searching...',
                        style: h4TextStyleInactive,
                      ),
                    ],
                  ),
                )
              : searchProvider.results.isEmpty
                  ? SliverToBoxAdapter(
                      child: Center(
                          child: Text(
                        'No search results',
                        style: h4TextStyleInactive,
                      )),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: searchProvider.results.length,
                        (context, index) => SearchResultItem(
                          model: searchProvider.results[index],
                        ),
                      ),
                    )
        ],
      ),
    );
  }
}
