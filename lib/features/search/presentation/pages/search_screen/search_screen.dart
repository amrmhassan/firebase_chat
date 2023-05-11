// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:firebase_chat/core/navigation.dart';
import 'package:firebase_chat/fast_tools/widgets/screen_wrapper.dart';
import 'package:firebase_chat/fast_tools/widgets/v_space.dart';
import 'package:firebase_chat/features/auth/data/models/user_model.dart';
import 'package:firebase_chat/features/theming/theme_calls.dart';
import 'package:firebase_chat/init/user_info.dart';
import 'package:flutter/material.dart';

import '../../../../../fast_tools/widgets/custom_text_field.dart';
import '../../../../home/presentation/widgets/home_screen_appbar.dart';
import '../../../../theming/constants/sizes.dart';
import '../../../../theming/constants/styles.dart';

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
    UserModel userModel = CUserInfo.instance.currentUser!;

    return ScreenWrapper(
        backgroundColor: colorTheme.backGround,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
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
                                child: CustomTextField(
                                  title: 'Search...',
                                  enabled: true,
                                  controller: searchController,
                                  onChange: (value) {},
                                  autoFocus: true,
                                  textInputType: TextInputType.text,
                                  password: false,
                                  handleShowPassword: () {},
                                  obscureText: false,
                                  color: Colors.red,
                                  backgroundColor:
                                      colorTheme.textFieldBackgroundColor,
                                  borderColor: Colors.transparent,
                                  textStyle: h4TextStyleInactive,
                                  borderRadius:
                                      BorderRadius.circular(mediumBorderRadius),
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
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: double.infinity),
                  VSpace(),
                  VSpace(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: double.infinity),
                      ...List.generate(
                        100,
                        (index) => Text('data'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
