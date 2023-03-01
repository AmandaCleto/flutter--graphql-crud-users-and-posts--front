import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_crud_users/data/models/authors/get_authors.dart';
import 'package:graphql_crud_users/data/queries/authors/author_mutation.dart';
import 'package:graphql_crud_users/data/queries/authors/author_query.dart';
import 'package:graphql_crud_users/data/queries/posts/post_mutation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PostWritingMixin {
  Future<String> createAuthor({
    required ValueNotifier<GraphQLClient> client,
    required String firstName,
    required String lastName,
  }) async {
    try {
      String mutation =
          AuthorMutation.createUser(firstName: firstName, lastName: lastName);

      QueryResult result = await client.value.mutate(
        MutationOptions(document: gql(mutation)),
      );

      if (result.hasException) {
        inspect(result.exception?.graphqlErrors[0].message);

        throw '';
      } else {
        if (result.data != null) {
          String authorId = result.data!["createUser"]['_id'];

          return authorId;
        } else {
          throw '';
        }
      }
    } catch (e) {
      throw '';
    }
  }

  Future<List<GetAuthors?>> getAuthors({
    required ValueNotifier<GraphQLClient> client,
  }) async {
    try {
      String query = AuthorQuery.getAuthors;

      QueryResult result = await client.value.query(
        QueryOptions(document: gql(query)),
      );

      if (result.hasException) {
        inspect(result.exception?.graphqlErrors[0].message);

        throw '';
      } else {
        if (result.data != null) {
          var rawList = List.of(result.data!["users"]);

          List<GetAuthors> listAuthors =
              rawList.map((jsonChat) => GetAuthors.fromJson(jsonChat)).toList();
          return listAuthors;
        } else {
          return [];
        }
      }
    } catch (e) {
      throw '';
    }
  }

  Future<void> createPost({
    required ValueNotifier<GraphQLClient> client,
    required String authorId,
    required String title,
    required String content,
  }) async {
    try {
      String user = PostMutation.createPost(
        authorId: authorId,
        content: content,
        title: title,
      );

      QueryResult result = await client.value.mutate(
        MutationOptions(
          document: gql(user),
        ),
      );

      if (result.hasException) {
        inspect(result.exception?.graphqlErrors[0].message);
      }
    } catch (e) {
      inspect(e);
    }
  }
}
