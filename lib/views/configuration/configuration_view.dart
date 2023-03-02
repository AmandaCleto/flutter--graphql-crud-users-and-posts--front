import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_crud_users/app/config/routes/constants.dart';
import 'package:graphql_crud_users/data/models/authors/get_author_id.dart';
import 'package:graphql_crud_users/data/queries/authors/author_query.dart';
import 'package:graphql_crud_users/shared/components/alert_dialog_widget.dart';
import 'package:graphql_crud_users/shared/components/query_has_exception_widget.dart';
import 'package:graphql_crud_users/shared/layouts/query_refresh_layout.dart';
import 'package:graphql_crud_users/shared/extensions/size_extension.dart';
import 'package:graphql_crud_users/shared/messages/messages_enum.dart';
import 'package:graphql_crud_users/shared/themes/colors.dart';
import 'package:graphql_crud_users/shared/themes/font_sizes.dart';
import 'package:graphql_crud_users/views/configuration/components/item_widget.dart';
import 'package:graphql_crud_users/views/configuration/configuration_mixin.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import '../../shared/utils/refresh_page_mixin.dart';

class ConfigurationView extends StatefulWidget {
  const ConfigurationView({Key? key}) : super(key: key);

  @override
  State<ConfigurationView> createState() => _ConfigurationViewState();
}

class _ConfigurationViewState extends State<ConfigurationView>
    with RefreshPageMixin, ConfigurationMixin {
  late List<GetAuthor>? listAuthors;
  @override
  Widget build(BuildContext context) {
    var client = context.read<ValueNotifier<GraphQLClient>?>();

    return GraphQLProvider(
      client: client,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('CONFIGURATION'),
        ),
        body: Query(
          options: QueryOptions<List<GetAuthor>>(
            parserFn: (Map<String, dynamic> json) {
              var rawList = List.of(json["users"]);

              return rawList
                  .map((jsonChat) => GetAuthor.fromJson(jsonChat))
                  .toList();
            },
            document: gql(AuthorQuery.getAuthors),
          ),
          builder: (
            QueryResult result, {
            VoidCallback? refetch,
            FetchMore? fetchMore,
          }) {
            if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (result.hasException) {
              return QueryHasExceptionWidget(
                onRefresh: refreshPage,
              );
            } else if ((result.parsedData as List<GetAuthor>).isEmpty) {
              return QueryRefreshLayout(
                onRefresh: refreshPage,
                body: const [
                  Text(
                    "Oh no! There is no authors created yet...",
                    style: TextStyle(
                      color: ColorsTheme.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSizesTheme.subtitle,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    "You can create author by adding a new post :)",
                    style: TextStyle(
                      color: ColorsTheme.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSizesTheme.subtitle,
                    ),
                  ),
                ],
              );
            } else {
              listAuthors = (result.parsedData as List<GetAuthor>).toList();
              return RefreshIndicator(
                color: ColorsTheme.white,
                backgroundColor: ColorsTheme.primary,
                onRefresh: refreshPage,
                child: SizedBox(
                  height: context.screenHeight,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: listAuthors!.length,
                    padding: const EdgeInsets.all(20.0),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: index == 0,
                            child: const Padding(
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: Text(
                                'Authors',
                                style: TextStyle(
                                  color: ColorsTheme.white,
                                  fontSize: FontSizesTheme.title,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: index == listAuthors!.length
                                ? const EdgeInsets.all(0)
                                : const EdgeInsets.only(bottom: 20.0),
                            child: ItemWidget(
                              firstName: listAuthors![index].firstName,
                              lastName: listAuthors![index].lastName,
                              editCallback: () async {
                                var result =
                                    await Navigator.of(context).pushNamed(
                                  configurationEditRoute,
                                  arguments: ScreenArguments(
                                    listAuthors![index].id,
                                    listAuthors![index].firstName,
                                    listAuthors![index].lastName,
                                  ),
                                );

                                if (result == true) {
                                  setState(() {});
                                }
                              },
                              deleteCallback: () async {
                                bool? result = await deleteAuthor(
                                  context,
                                  client: client!,
                                  authorId: listAuthors![index].id,
                                  fullName:
                                      "${listAuthors![index].firstName} ${listAuthors![index].lastName}",
                                );

                                if (result == true) {
                                  refetch!();
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
