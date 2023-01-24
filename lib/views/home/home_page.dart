import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_crud_users/views/home/home_mixin.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomePage extends StatefulWidget {
  final ValueNotifier<GraphQLClient> clientNotifier;

  const HomePage({super.key, required this.clientNotifier});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomeMixin {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: widget.clientNotifier,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('CRUD com GraphQL'),
        ),
        body: Query(
          options: QueryOptions(
            document: gql(readRepositories),
          ),
          builder: (
            QueryResult result, {
            VoidCallback? refetch,
            FetchMore? fetchMore,
          }) {
            inspect(result);
            if (result.data == null) {
              return const Center(
                child: Text("Deu bad"),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemBuilder: (BuildContext context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      index == 0
                          ? const Text('Lista de Usuários')
                          : const SizedBox.shrink(),
                      Text(
                        result.data!['users'][index]['fullName'],
                      ),
                    ],
                  );
                },
                itemCount: result.data!['users'].length,
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          createUser(client: widget.clientNotifier);
        }),
      ),
    );
  }
}

String readRepositories = """
  query{
  users{
    fullName
  }
}
""";
