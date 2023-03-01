import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_crud_users/data/queries/authors/author_mutation.dart';
import 'package:graphql_crud_users/data/queries/posts/post_mutation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../shared/components/alert_dialog_widget.dart';

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

  Future<bool> _deleteAuthor({
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
        return false;
      } else if (result.data != null) {
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAuthor(
    context, {
    required ValueNotifier<GraphQLClient> client,
    required String authorId,
    required String fullName,
  }) async {
    bool result = false;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogWidget(
          title: 'Are you sure?',
          content:
              'By deleting $fullName, all posts related to this author will be deleted as well',
          confirmationButtonText: "I'm sure!",
          denialButtonText: "No",
          confirmationFn: () async {
            result = await _deleteAuthor(client: client, authorId: authorId);
          },
        );
      },
    );

    return result;
  }

  editUser() async {}
}
