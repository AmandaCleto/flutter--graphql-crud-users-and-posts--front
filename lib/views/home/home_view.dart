import 'package:flutter/material.dart';

import 'package:graphql_crud_users/data/models/users/get_users_posts.dart';
import 'package:graphql_crud_users/data/queries/users/user_query.dart';
import 'package:graphql_crud_users/shared/theme/colors.dart';
import 'package:graphql_crud_users/shared/theme/font_sizes.dart';
import 'package:graphql_crud_users/shared/theme/gradient_decoration.dart';
import 'package:graphql_crud_users/views/home/components/post_widget.dart';
import 'package:graphql_crud_users/views/home/home_mixin.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeView extends StatefulWidget {
  final ValueNotifier<GraphQLClient> clientNotifier;

  const HomeView({super.key, required this.clientNotifier});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeMixin {
  late List<GetUsersPosts>? usersPosts;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: widget.clientNotifier,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('POSTS'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              padding: const EdgeInsets.all(20.0),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: const Icon(Icons.settings),
              onPressed: () {
                // do something
              },
            )
          ],
        ),
        body: Query(
          options: QueryOptions<List<GetUsersPosts>>(
            parserFn: (Map<String, dynamic> json) {
              var rawList = List.of(json["posts"]);

              return rawList
                  .map((jsonChat) => GetUsersPosts.fromJson(jsonChat))
                  .toList();
            },
            document: gql(UserQuery().getUsersPosts),
          ),
          builder: (
            QueryResult result, {
            VoidCallback? refetch,
            FetchMore? fetchMore,
          }) {
            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (result.hasException || result.data == null) {
              return const Center(
                child: Text("Deu bad"),
              );
            } else {
              usersPosts = result.parsedData as List<GetUsersPosts>;
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0) const SizedBox(height: 20.0),
                      // ElevatedButton(onPressed: refetch, child: Text("")),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: PostWidget(
                          title: usersPosts![index].title,
                          text: usersPosts![index].content,
                          author: usersPosts![index].authorFullName,
                          postId: usersPosts![index].postId,
                        ),
                      ),
                      if (index != usersPosts!.length)
                        const SizedBox(height: 20.0),
                    ],
                  );
                },
                itemCount: usersPosts!.length,
              );
            }
          },
        ),
        floatingActionButton: Container(
          decoration: GradientDecoration.bluePinkGradientDecoration,
          height: 60.0,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.transparent,
            splashColor: Colors.black26,
            focusColor: Colors.black26,
            hoverColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            highlightElevation: 0,
            hoverElevation: 0,
            elevation: 0,
            onPressed: () {
              // createUser(client: widget.clientNotifier);
            },
            icon: const Icon(
              Icons.border_color_rounded,
              color: ColorsTheme.blue,
            ),
            label: const Text(
              "write post",
              style: TextStyle(
                fontSize: FontSizesTheme.small,
                fontFamily: 'Roboto',
                color: ColorsTheme.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
