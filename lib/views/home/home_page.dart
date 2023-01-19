import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomePage extends StatefulWidget {
  final ValueNotifier<GraphQLClient> clientNotifier;

  const HomePage({super.key, required this.clientNotifier});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: widget.clientNotifier,
      child: Scaffold(
        appBar: AppBar(),
        body: Query(
          options: QueryOptions(
            document: gql(readRepositories),
          ),
          builder: (
            QueryResult result, {
            VoidCallback? refetch,
            FetchMore? fetchMore,
          }) {
            if (result.data == null) {
              return const Center(
                child: Text("Deu ruim"),
              );
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, index) => Text(
                result.data!['users'][index]['fullName'],
              ),
              itemCount: result.data!['users'].length,
            );
          },
        ),
      ),
    );
  }
}

String readRepositories = """
  query{
  users {
    _id, fullName
  }
}
""";
