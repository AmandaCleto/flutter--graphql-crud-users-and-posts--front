import 'package:graphql_crud_users/data/queries/posts/post_mutation.dart';
import 'package:graphql_crud_users/shared/exceptions/error_exception.dart';
import 'package:graphql_crud_users/shared/messages/messages_enum.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';

mixin HomeMixin {
  Future<bool> deletePost({
    required ValueNotifier<GraphQLClient> client,
    required String postId,
  }) async {
    try {
      String mutation = PostMutation.deletePost(postId: postId);

      var result = await client.value.mutate(
        MutationOptions(document: gql(mutation)),
      );

      if (result.data != null) {
        return true;
      } else {
        throw ErrorException(EMessages.errorGeneric.message).cause;
      }
    } on ErrorException catch (_) {
      rethrow;
    }
  }
}
