import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_crud_users/data/queries/authors/author_mutation.dart';
import 'package:graphql_crud_users/data/queries/authors/author_query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

mixin EditAuthorMixin {
  editAuthor({
    required ValueNotifier<GraphQLClient> client,
    required String firstName,
    required String lastName,
    required String authorId,
  }) async {
    try {
      String mutation = AuthorMutation.updateAuthor(
        firstName: firstName,
        lastName: lastName,
        authorId: authorId,
      );
      print('object');
      QueryResult result = await client.value.mutate(
        MutationOptions(document: gql(mutation)),
      );

      if (result.hasException) {
        throw '';
      } else {
        if (result.data != null) {
          var rawList = result.data!["updateUser"];

          inspect(rawList);

          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      throw '';
    }
  }
}
