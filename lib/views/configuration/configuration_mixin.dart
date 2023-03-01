import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_crud_users/data/queries/authors/author_mutation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

mixin ConfigurationMixin {
  Future<void> deleteAuthor({
    required ValueNotifier<GraphQLClient> client,
    required String userId,
  }) async {
    print(userId);
    try {
      String mutation = AuthorMutation.deleteAuthor(userId: userId);

      QueryResult result = await client.value.mutate(
        MutationOptions(document: gql(mutation)),
      );

      inspect(result);

      if (result.hasException) {
        inspect(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        inspect(result.data!["deleteUser"]);
      }

      // return "";
    } catch (e) {
      // return "";
    }
  }

  editUser() {}
}
