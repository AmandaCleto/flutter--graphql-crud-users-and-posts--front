import 'dart:developer';

import 'package:graphql_crud_users/data/queries/users/user_query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';

mixin HomeMixin {
  Future<String> createUser({
    required ValueNotifier<GraphQLClient> client,
  }) async {
    try {
      String user = UserQuery().createUser(
        firstName: 'amanda',
        lastName: 'Cleto',
        active: true,
        email: 'amand@gmail.com.br',
      );

      QueryResult result = await client.value.mutate(
        MutationOptions(
          document: gql(user),
        ),
      );

      if (result.hasException) {
        inspect(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        //  parse your response here and return
        // var data = User.fromJson(result.data["register"]);
      }

      return "";
    } catch (e) {
      inspect(e);
      return "";
    }
  }
}
