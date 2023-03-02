import 'package:flutter/material.dart';
import 'package:graphql_crud_users/data/queries/authors/author_mutation.dart';
import 'package:graphql_crud_users/shared/exceptions/error_exception.dart';
import 'package:graphql_crud_users/shared/messages/messages_enum.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

mixin EditAuthorMixin {
  Future<bool> editAuthor({
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

      QueryResult result = await client.value.mutate(
        MutationOptions(document: gql(mutation)),
      );

      if (result.data != null) {
        return true;
      } else {
        throw ErrorException(EMessages.errorGeneric.message).cause;
      }
    } catch (_) {
      rethrow;
    }
  }
}
