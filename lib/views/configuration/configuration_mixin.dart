import 'package:flutter/material.dart';
import 'package:graphql_crud_users/data/queries/authors/author_mutation.dart';
import 'package:graphql_crud_users/data/queries/posts/post_mutation.dart';
import 'package:graphql_crud_users/shared/messages/messages_enum.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../shared/components/alert_dialog_widget.dart';

mixin ConfigurationMixin {
  Future<bool> _deleteAllPostsFromAuthorId({
    required ValueNotifier<GraphQLClient> client,
    required String authorId,
  }) async {
    String mutation = PostMutation.deleteAllPostsFromAuthorId(
      authorId: authorId,
    );

    QueryResult result = await client.value.mutate(
      MutationOptions(document: gql(mutation)),
    );

    if (result.data != null) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  Future<bool> _deleteAuthor({
    required ValueNotifier<GraphQLClient> client,
    required String authorId,
  }) async {
    String mutation = AuthorMutation.deleteAuthor(authorId: authorId);

    QueryResult result = await client.value.mutate(
      MutationOptions(document: gql(mutation)),
    );

    bool hasDeleted = await _deleteAllPostsFromAuthorId(
      client: client,
      authorId: authorId,
    );

    if (result.data != null && hasDeleted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool?> deleteAuthor(
    context, {
    required ValueNotifier<GraphQLClient> client,
    required String authorId,
    required String fullName,
  }) async {
    bool? result;
    var navigator = Navigator.of(context);

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
            navigator.pop();
          },
        );
      },
    );

    if (result == false) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialogWidget.error(
            title: 'Attention!',
            content: EMessages.errorGeneric.message,
          );
        },
      );
    }

    return result;
  }
}
