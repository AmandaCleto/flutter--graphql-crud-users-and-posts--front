// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:graphql_crud_users/shared/extensions/size_extension.dart';
import 'package:graphql_crud_users/shared/themes/colors.dart';

class QueryRefreshLayout extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final List<Widget> body;

  const QueryRefreshLayout({
    Key? key,
    required this.onRefresh,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: ColorsTheme.white,
      backgroundColor: ColorsTheme.primary,
      onRefresh: onRefresh,
      child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            width: context.screenWidth,
            height: constraints.maxHeight,
            padding: EdgeInsets.only(top: context.percentHeight(0.25)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: body,
            ),
          ),
        );
      }),
    );
  }
}
