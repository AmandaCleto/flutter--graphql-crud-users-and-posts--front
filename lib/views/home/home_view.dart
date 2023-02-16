import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_crud_users/app/config/routes/constants.dart';

import 'package:graphql_crud_users/data/models/authors/get_authors_posts.dart';
import 'package:graphql_crud_users/data/queries/authors/author_query.dart';
import 'package:graphql_crud_users/shared/components/button_gradient_widget.dart';
import 'package:graphql_crud_users/shared/extensions/size_extension.dart';
import 'package:graphql_crud_users/shared/theme/colors.dart';
import 'package:graphql_crud_users/shared/theme/font_sizes.dart';
import 'package:graphql_crud_users/shared/theme/gradient_decoration.dart';
import 'package:graphql_crud_users/views/home/components/post_widget.dart';
import 'package:graphql_crud_users/views/home/home_controller.dart';
import 'package:graphql_crud_users/views/home/home_mixin.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeMixin {
  late List<GetAuthorsPosts>? usersPosts;
  final homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    var client = context.read<ValueNotifier<GraphQLClient>?>();

    return GraphQLProvider(
      client: client,
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
          options: QueryOptions<List<GetAuthorsPosts>>(
            parserFn: (Map<String, dynamic> json) {
              var rawList = List.of(json["posts"]);

              return rawList
                  .map((jsonChat) => GetAuthorsPosts.fromJson(jsonChat))
                  .toList();
            },
            onComplete: (Map<String, dynamic> json) {
              if (json["posts"].isNotEmpty) {
                homeController.turnHasDataOn();
              } else {
                homeController.turnHasDataOff();
              }
            },
            document: gql(AuthorQuery.getAuthorsPosts),
          ),
          builder: (
            QueryResult result, {
            VoidCallback? refetch,
            FetchMore? fetchMore,
          }) {
            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (result.hasException) {
              return Container(
                width: context.screenWidth,
                padding: EdgeInsets.only(top: context.percentHeight(0.25)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Text(
                      "Something went wrong :(",
                      style: TextStyle(
                        color: ColorsTheme.white,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSizesTheme.subtitle,
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Text(
                      "Please verify your internet \n connection, and try it again.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorsTheme.white,
                        fontSize: FontSizesTheme.bodyText,
                      ),
                    ),
                  ],
                ),
              );
            } else if ((result.parsedData as List<GetAuthorsPosts>).isEmpty) {
              return Container(
                width: context.screenWidth,
                padding: EdgeInsets.only(top: context.percentHeight(0.25)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      "Oh no! There is no posts yet..",
                      style: TextStyle(
                        color: ColorsTheme.white,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSizesTheme.subtitle,
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    const Text(
                      "How about creating one?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorsTheme.white,
                        fontSize: FontSizesTheme.bodyText,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    ButtonGradientWidget.iconWrite(
                      onPressed: () =>
                          Navigator.of(context).pushNamed(postWriting),
                      text: 'write post',
                      width: context.percentWidth(0.35),
                    ),
                  ],
                ),
              );
            } else {
              usersPosts = result.parsedData as List<GetAuthorsPosts>;

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0) const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: PostWidget(
                          title: usersPosts![index].title,
                          text: usersPosts![index].content,
                          author: usersPosts![index].authorFullName,
                          postId: usersPosts![index].postId,
                          callbackFn: () async {
                            await deletePost(
                              client: client!,
                              postId: usersPosts![index].postId,
                            );

                            refetch!();
                          },
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
        floatingActionButton: ValueListenableBuilder<bool>(
          valueListenable: homeController,
          builder: (context, value, child) {
            return Visibility(
              visible: value,
              child: Container(
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
                  onPressed: () => Navigator.of(context).pushNamed(postWriting),
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
            );
          },
        ),
      ),
    );
  }
}
