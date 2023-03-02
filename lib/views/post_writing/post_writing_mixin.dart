import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_crud_users/data/models/authors/get_authors.dart';
import 'package:graphql_crud_users/data/queries/authors/author_mutation.dart';
import 'package:graphql_crud_users/data/queries/authors/author_query.dart';
import 'package:graphql_crud_users/data/queries/posts/post_mutation.dart';
import 'package:graphql_crud_users/shared/exceptions/error_exception.dart';
import 'package:graphql_crud_users/shared/messages/messages_enum.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PostWritingMixin {
  Future<String> _createAuthor({
    required ValueNotifier<GraphQLClient> client,
    required String firstName,
    required String lastName,
  }) async {
    String mutation = AuthorMutation.createUser(
      firstName: firstName,
      lastName: lastName,
    );

    QueryResult result = await client.value.mutate(
      MutationOptions(document: gql(mutation)),
    );

    if (result.data != null) {
      String authorId = result.data!["createUser"]['_id'];

      return authorId;
    } else {
      return "";
    }
  }

  Future<List<GetAuthors?>> getAuthors({
    required ValueNotifier<GraphQLClient> client,
  }) async {
    String query = AuthorQuery.getAuthors;

    QueryResult result = await client.value.query(
      QueryOptions(document: gql(query)),
    );

    if (result.data != null) {
      var rawList = List.of(result.data!["users"]);

      List<GetAuthors> listAuthors = rawList
          .map(
            (jsonChat) => GetAuthors.fromJson(jsonChat),
          )
          .toList();

      return listAuthors;
    } else {
      return [];
    }
  }

  Future<bool> createPost({
    required ValueNotifier<GraphQLClient> client,
    required String authorId,
    required String title,
    required String content,
    required String firstName,
    required String lastName,
  }) async {
    try {
      String localAuthorId = authorId;

      if (localAuthorId.isEmpty) {
        localAuthorId = await _createAuthor(
          client: client,
          firstName: firstName,
          lastName: lastName,
        );
      }

      if (localAuthorId.isNotEmpty) {
        String user = PostMutation.createPost(
          authorId: localAuthorId,
          content: content,
          title: title,
        );

        QueryResult result = await client.value.mutate(
          MutationOptions(document: gql(user)),
        );

        if (result.data != null) {
          return true;
        } else {
          throw ErrorException(EMessages.errorGeneric.message).cause;
        }
      } else {
        throw ErrorException(EMessages.errorGeneric.message).cause;
      }
    } on ErrorException catch (_) {
      rethrow;
    }
  }
}
