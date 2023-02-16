import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_crud_users/data/models/authors/get_author_id.dart';
import 'package:graphql_crud_users/data/models/authors/get_authors.dart';
import 'package:graphql_crud_users/data/queries/authors/author_query.dart';
import 'package:graphql_crud_users/data/queries/posts/post_mutation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PostWritingMixin {
  Future<GetAuthorId> getAuthorId({
    required ValueNotifier<GraphQLClient> client,
    required String authorId,
  }) async {
    try {
      String mutation = AuthorQuery.getAuthorId(authorId);

      QueryResult result = await client.value.query(
        QueryOptions(document: gql(mutation)),
      );

      if (result.hasException) {
        inspect(result.exception?.graphqlErrors[0].message);

        throw '';
      } else {
        if (result.data != null) {
          var rawList = result.data!["user"];

          var author = GetAuthorId.fromJson(rawList);

          return author;
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
      String mutation = AuthorQuery.getAuthors;

      QueryResult result = await client.value.query(
        QueryOptions(document: gql(mutation)),
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

  Future<String> createPost({
    required ValueNotifier<GraphQLClient> client,
    required String firstName,
    required String lastName,
    required String title,
    required String content,
  }) async {
    try {
      String user = PostMutation.createPost(
        authorId: firstName,
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
      } else if (result.data != null) {
        //  parse your response here and return
        // var data = User.fromJson(result.data["register"]);
      }

      return "";
    } catch (e) {
      inspect(e);
      return "";
    }
  }
}
