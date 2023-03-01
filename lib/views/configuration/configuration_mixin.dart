import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_crud_users/data/queries/authors/author_mutation.dart';
import 'package:graphql_crud_users/data/queries/posts/post_mutation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

mixin ConfigurationMixin {
  _deleteAllPostsFromAuthorId({
    required ValueNotifier<GraphQLClient> client,
    required String authorId,
  }) async {
    try {
      String mutation =
          PostMutation.deleteAllPostsFromAuthorId(authorId: authorId);

      QueryResult result = await client.value.mutate(
        MutationOptions(document: gql(mutation)),
      );

      if (result.hasException) {
        inspect(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        inspect(result.data!["deleteAllPostFromUserId"]);
      }

      // return "";
    } catch (e) {
      // return "";
    }
  }

  Future<void> deleteAuthor({
    required ValueNotifier<GraphQLClient> client,
    required String authorId,
  }) async {
    try {
      String mutation = AuthorMutation.deleteAuthor(authorId: authorId);

      QueryResult result = await client.value.mutate(
        MutationOptions(document: gql(mutation)),
      );

      await _deleteAllPostsFromAuthorId(client: client, authorId: authorId);

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

  editUser() async {}
}
