import 'package:flutter/material.dart';
import 'package:graphql_crud_users/data/models/authors/get_authors.dart';
import 'package:graphql_crud_users/data/queries/authors/author_query.dart';
import 'package:graphql_crud_users/shared/themes/colors.dart';
import 'package:graphql_crud_users/shared/themes/font_sizes.dart';
import 'package:graphql_crud_users/views/post_writing/components/no_data_select_widget.dart';
import 'package:graphql_crud_users/views/post_writing/components/select_controller.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class SelectWidget extends StatefulWidget {
  final Function(String? optionSelected, String authorId)
      callbackValueWhenSelectFn;

  const SelectWidget({super.key, required this.callbackValueWhenSelectFn});

  @override
  State<SelectWidget> createState() => _SelectWidgetState();
}

class _SelectWidgetState extends State<SelectWidget> {
  SelectController selectController = SelectController();

  late String dropdownValue;
  late List<GetAuthors> authors;

  @override
  Widget build(BuildContext context) {
    var client = context.read<ValueNotifier<GraphQLClient>?>();

    return GraphQLProvider(
      client: client,
      child: Query(
        options: QueryOptions<List<GetAuthors>>(
          parserFn: (Map<String, dynamic> json) {
            var rawList = List.of(json["users"]);

            return rawList
                .map((jsonChat) => GetAuthors.fromJson(jsonChat))
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
            return const NoDataSelect.loading();
          } else if (result.hasException) {
            return const NoDataSelect();
          } else if ((result.parsedData as List<GetAuthors>).isEmpty) {
            return const NoDataSelect();
          } else {
            authors = result.parsedData as List<GetAuthors>;

            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ValueListenableBuilder(
                  valueListenable: selectController,
                  builder: (context, value, child) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                        onPressed: value == null
                            ? null
                            : () {
                                widget.callbackValueWhenSelectFn("", "");
                                selectController.setValue = null;
                              },
                        splashRadius: 20.0,
                        icon: Icon(
                          Icons.delete,
                          color: value == null
                              ? ColorsTheme.blue.withOpacity(0.5)
                              : ColorsTheme.blue,
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: ColorsTheme.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ValueListenableBuilder<String?>(
                    valueListenable: selectController,
                    builder: (context, value, child) {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: value,
                          hint: const Text("Registered authors"),
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: ColorsTheme.blue,
                          ),
                          elevation: 16,
                          dropdownColor: ColorsTheme.white,
                          style: const TextStyle(
                            color: ColorsTheme.blue,
                            fontSize: FontSizesTheme.bodyText,
                          ),
                          isDense: true,
                          borderRadius: BorderRadius.circular(20.0),
                          onChanged: (String? value) {
                            if (value != null) {
                              selectController.setValue = value;

                              for (var author in authors) {
                                if (author.id == value) {
                                  widget.callbackValueWhenSelectFn(
                                    author.fullName,
                                    author.id,
                                  );
                                }
                              }
                            }
                          },
                          items: authors.map<DropdownMenuItem<String>>(
                            (GetAuthors value) {
                              return DropdownMenuItem<String>(
                                value: value.id,
                                child: Text(value.fullName),
                              );
                            },
                          ).toList(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
