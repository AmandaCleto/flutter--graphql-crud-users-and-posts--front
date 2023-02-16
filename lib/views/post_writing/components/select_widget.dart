import 'package:flutter/material.dart';
import 'package:graphql_crud_users/data/models/authors/get_authors.dart';
import 'package:graphql_crud_users/data/queries/authors/author_query.dart';
import 'package:graphql_crud_users/shared/theme/colors.dart';
import 'package:graphql_crud_users/shared/theme/font_sizes.dart';
import 'package:graphql_crud_users/views/post_writing/components/no_data_select_widget.dart';
import 'package:graphql_crud_users/views/post_writing/components/select_controller.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class SelectWidget extends StatefulWidget {
  final Function(String? optionSelected) callbackValueWhenSelectFn;

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

            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                      hint: const Text("Pick Author"),
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
                        selectController.setValue(value!);
                        widget
                            .callbackValueWhenSelectFn(selectController.value);
                      },
                      items: authors
                          .map<DropdownMenuItem<String>>((GetAuthors value) {
                        return DropdownMenuItem<String>(
                          value: value.fullName,
                          child: Text(value.fullName),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
