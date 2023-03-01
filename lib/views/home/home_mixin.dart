import 'dart:developer';

import 'package:graphql_crud_users/data/queries/posts/post_mutation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';

mixin HomeMixin {
  Future<String> deletePost({
    required ValueNotifier<GraphQLClient> client,
    required String postId,
  }) async {
    try {
      String mutation = PostMutation.deletePost(postId: postId);

      QueryResult result = await client.value.mutate(
        MutationOptions(document: gql(mutation)),
      );

      if (result.hasException) {
        inspect(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        return result.data!["deletePost"];
      }

      return "";
    } catch (e) {
      return "";
    }
  }
}
