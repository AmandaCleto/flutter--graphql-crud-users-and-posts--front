// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:graphql_crud_users/shared/layouts/query_refresh_layout.dart';

import 'package:graphql_crud_users/shared/themes/colors.dart';

import '../themes/font_sizes.dart';

class QueryHasExceptionWidget extends QueryRefreshLayout {
  const QueryHasExceptionWidget({super.key, required super.onRefresh})
      : super(
          body: const [
            Text(
              "Something went wrong :(",
              style: TextStyle(
                color: ColorsTheme.white,
                fontWeight: FontWeight.bold,
                fontSize: FontSizesTheme.subtitle,
              ),
            ),
            SizedBox(height: 40.0),
            Text(
              "Please verify your internet \n connection, and try it again.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorsTheme.white,
                fontSize: FontSizesTheme.bodyText,
              ),
            ),
          ],
        );
}
